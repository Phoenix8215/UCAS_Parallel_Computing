#include <iostream>
#include <mpi.h>

int main( int argc, char *argv[] ) 
{
    MPI_Init( &argc, &argv );
    int rank, size;

    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    int indegree, outdegree, *sources, *sourceweights, *destinations, *destweights;

    if ( rank == 0 ) { //centre of the star
        indegree = outdegree = size - 1;
        sources = new int[size - 1];
        sourceweights = new int[size - 1];
        destinations = new int[size - 1];
        destweights = new int[size - 1];
        for ( int i = 0; i < size - 1; i++ ) {
            sources[i] = destinations[i] = i + 1;
            sourceweights[i] = destweights[i] = 1;
        }
    }
    else { // tips of the star
        indegree = outdegree =  1;
        sources = new int[1];
        sourceweights = new int[1];
        destinations = new int[1];
        destweights = new int[1];
        sources[0] = destinations[0] = 0;
        sourceweights[0] = destweights[0] = 1;
    }

    MPI_Comm star;
    MPI_Dist_graph_create_adjacent( MPI_COMM_WORLD, indegree, sources, sourceweights,
                                    outdegree, destinations, destweights, MPI_INFO_NULL,
                                    true, &star );
    delete[] sources;
    delete[] sourceweights;
    delete[] destinations;
    delete[] destweights;

    int starrank;

    MPI_Comm_rank( star, &starrank );

    std::cout << "Process #" << rank << " of MPI_COMM_WORLD is process #" << starrank << " of the star\n";

    MPI_Comm_free( &star);

    MPI_Finalize();

    return 0;
}