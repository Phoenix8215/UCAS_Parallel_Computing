#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
#define NELEM 25

int main(int argc, char *argv[])  
{
  int numtasks, rank, source=0, dest, tag=1, i;

  typedef struct {
    float x, y, z;
    float velocity;
    int  n, type;
    }          Particle;
  Particle     p[NELEM], particles[NELEM];
  MPI_Datatype particletype, oldtypes[2];   // required variables
  int          blockcounts[2];

  // MPI_Aint type used to be consistent with syntax of
  // MPI_Type_extent routine
  MPI_Aint    offsets[2], extent;

  MPI_Status stat;
  MPI_Status stats[2];
	MPI_Request reqs[2];

  MPI_Init(&argc,&argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &numtasks);

  // setup description of the 4 MPI_FLOAT fields x, y, z, velocity
  offsets[0] = 0;
  oldtypes[0] = MPI_FLOAT;
  blockcounts[0] = 4;

  // setup description of the 2 MPI_INT fields n, type
  // need to first figure offset by getting size of MPI_FLOAT
  MPI_Type_extent(MPI_FLOAT, &extent);
  offsets[1] = 4 * extent;
  oldtypes[1] = MPI_INT;
  blockcounts[1] = 2;

  // define structured type and commit it
  MPI_Type_struct(2, blockcounts, offsets, oldtypes, &particletype);
  MPI_Type_commit(&particletype);

  // all tasks receive particletype data
  // MPI_Recv(p, NELEM, particletype, source, tag, MPI_COMM_WORLD, &stat);
  MPI_Irecv(p, NELEM, particletype, source, tag, MPI_COMM_WORLD, &reqs[0]);

  // task 0 initializes the particle array and then sends it to each task
  if (rank == 0) {
    for (i=0; i<NELEM; i++) {
      particles[i].x = i * 1.0;
      particles[i].y = i * -1.0;
      particles[i].z = i * 1.0; 
      particles[i].velocity = 0.25;
      particles[i].n = i;
      particles[i].type = i % 2; 
    }
    for (i=0; i<numtasks; i++) 
      MPI_Send(particles, NELEM, particletype, i, tag, MPI_COMM_WORLD);
  }

  MPI_Waitall(1, reqs, stats);

  if(numtasks >= NELEM) {
    printf("numtasks should smaller than Num elements.\n");
    exit(0); 
  }
  printf("rank= %d   %3.2f %3.2f %3.2f %3.2f %d %d\n", 
    rank,p[rank].x,p[rank].y,p[rank].z,p[rank].velocity,p[rank].n,p[rank].type);

  // free datatype when done using it
  MPI_Type_free(&particletype);
  MPI_Finalize();
}