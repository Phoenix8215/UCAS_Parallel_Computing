<!DOCTYPE HTML>
<html>

<head>
    <meta charset="utf-8">

    <title>01-prefetch-check-solution.cu (editing)</title>
    <link id="favicon" rel="shortcut icon" type="image/x-icon" href="/lab/static/base/images/favicon-file.ico?v=f9f0a782d7d67b3a57bf7dce251d771b405c7890604576ec8b9a621a39d7670f6b43ffabef1e566f1cd741ee302e15977d9e1cf60bbacebafe75787b9916415c">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" href="/lab/static/components/jquery-ui/themes/smoothness/jquery-ui.min.css?v=fb45616eef2c454960f91fcd2a04efeda84cfacccf0c5d741ba2793dc1dbd6d3ab01aaae6485222945774c7d7a9a2e9fb87e0d8ef1ea96893aa6906147a371bb" type="text/css" />
    <link rel="stylesheet" href="/lab/static/components/jquery-typeahead/dist/jquery.typeahead.min.css?v=5edf53bf6bb9c3b1ddafd8594825a7e2ed621f19423e569c985162742f63911c09eba2c529f8fb47aebf27fafdfe287d563347f58c1126b278189a18871b6a9a" type="text/css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    
<link rel="stylesheet" href="/lab/static/components/codemirror/lib/codemirror.css?v=81fecb54f83101e2bbe6d2e3131e252ac83f2910366100ca83ba4834f5d41754c837f306eecfdceed05f9c9111614942e2ced5acdd8040746b66c6bef0141d0e">
<link rel="stylesheet" href="/lab/static/components/codemirror/addon/dialog/dialog.css?v=e7f5db4afaccf8a00c10d62c3693642323d3fcf17604a4797803df04e4f144a944dc646c2fda20548df538ada775570127b2a15403996a171ced1769697f3ee4">

    <link rel="stylesheet" href="/lab/static/style/style.min.css?v=56dfd556850eb17b7998c6828467598a322b41593edc758739c66cb2c3fea98f23d0dd8bf8b9b0f5d67bb976a50e4c34f789fe640cbb440fa089e1bf5ec170bd" type="text/css"/>
    

    <link rel="stylesheet" href="/lab/custom/custom.css" type="text/css" />
    <script src="/lab/static/components/es6-promise/promise.min.js?v=bea335d74136a63ae1b5130f5ac9a50c6256a5f435e6e09fef599491a84d834a8b0f011ca3eaaca3b4ab6a2da2d3e1191567a2f171e60da1d10e5b9d52f84184" type="text/javascript" charset="utf-8"></script>
    <script src="/lab/static/components/react/react.production.min.js?v=9a0aaf84a316c8bedd6c2ff7d5b5e0a13f8f84ec02442346cba0b842c6c81a6bf6176e64f3675c2ebf357cb5bb048e0b527bd39377c95681d22468da3d5de735" type="text/javascript"></script>
    <script src="/lab/static/components/react/react-dom.production.min.js?v=6fc58c1c4736868ff84f57bd8b85f2bdb985993a9392718f3b4af4bfa10fb4efba2b4ddd68644bd2a8daf0619a3844944c9c43f8528364a1aa6fc01ec1b8ae84" type="text/javascript"></script>
    <script src="/lab/static/components/create-react-class/index.js?v=894ad57246e682b4cfbe7cd5e408dcd6b38d06af4de4f3425991e2676fdc2ef1732cbd19903104198878ae77de12a1996de3e7da3a467fb226bdda8f4618faec" type="text/javascript"></script>
    <script src="/lab/static/components/requirejs/require.js?v=d37b48bb2137faa0ab98157e240c084dd5b1b5e74911723aa1d1f04c928c2a03dedf922d049e4815f7e5a369faa2e6b6a1000aae958b7953b5cc60411154f593" type="text/javascript" charset="utf-8"></script>
    <script>
      require.config({
          
          urlArgs: "v=20210706082808",
          
          baseUrl: '/lab/static/',
          paths: {
            'auth/js/main': 'auth/js/main.min',
            custom : '/lab/custom',
            nbextensions : '/lab/nbextensions',
            kernelspecs : '/lab/kernelspecs',
            underscore : 'components/underscore/underscore-min',
            backbone : 'components/backbone/backbone-min',
            jed: 'components/jed/jed',
            jquery: 'components/jquery/jquery.min',
            json: 'components/requirejs-plugins/src/json',
            text: 'components/requirejs-text/text',
            bootstrap: 'components/bootstrap/dist/js/bootstrap.min',
            bootstraptour: 'components/bootstrap-tour/build/js/bootstrap-tour.min',
            'jquery-ui': 'components/jquery-ui/jquery-ui.min',
            moment: 'components/moment/min/moment-with-locales',
            codemirror: 'components/codemirror',
            termjs: 'components/xterm.js/xterm',
            typeahead: 'components/jquery-typeahead/dist/jquery.typeahead.min',
          },
          map: { // for backward compatibility
              "*": {
                  "jqueryui": "jquery-ui",
              }
          },
          shim: {
            typeahead: {
              deps: ["jquery"],
              exports: "typeahead"
            },
            underscore: {
              exports: '_'
            },
            backbone: {
              deps: ["underscore", "jquery"],
              exports: "Backbone"
            },
            bootstrap: {
              deps: ["jquery"],
              exports: "bootstrap"
            },
            bootstraptour: {
              deps: ["bootstrap"],
              exports: "Tour"
            },
            "jquery-ui": {
              deps: ["jquery"],
              exports: "$"
            }
          },
          waitSeconds: 30,
      });

      require.config({
          map: {
              '*':{
                'contents': 'services/contents',
              }
          }
      });

      // error-catching custom.js shim.
      define("custom", function (require, exports, module) {
          try {
              var custom = require('custom/custom');
              console.debug('loaded custom.js');
              return custom;
          } catch (e) {
              console.error("error loading custom.js", e);
              return {};
          }
      })

    document.nbjs_translations = {"domain": "nbjs", "locale_data": {"nbjs": {"": {"domain": "nbjs"}, "Manually edit the JSON below to manipulate the metadata for this cell.": ["\u624b\u52a8\u7f16\u8f91\u4e0b\u9762\u7684 JSON \u4ee3\u7801\u6765\u4fee\u6539\u5757\u5143\u6570\u636e\u3002"], "Manually edit the JSON below to manipulate the metadata for this notebook.": ["\u624b\u52a8\u7f16\u8f91\u4e0b\u9762\u7684 JSON \u4ee3\u7801\u6765\u4fee\u6539\u7b14\u8bb0\u672c\u5143\u6570\u636e\u3002"], " We recommend putting custom metadata attributes in an appropriately named substructure, so they don't conflict with those of others.": ["\u6211\u4eec\u5efa\u8bae\u5c06\u81ea\u5b9a\u4e49\u7684\u5143\u6570\u636e\u5c5e\u6027\u653e\u5165\u9002\u5f53\u7684\u5b50\u7ed3\u6784\u4e2d\uff0c\u8fd9\u6837\u5c31\u4e0d\u4f1a\u4e0e\u5176\u4ed6\u7684\u5b50\u7ed3\u6784\u53d1\u751f\u51b2\u7a81\u3002"], "Edit the metadata": ["\u7f16\u8f91\u5143\u6570\u636e"], "Edit Notebook Metadata": ["\u7f16\u8f91\u7b14\u8bb0\u672c\u5143\u6570\u636e"], "Edit Cell Metadata": ["\u7f16\u8f91\u5757\u5143\u6570\u636e"], "Cancel": ["\u53d6\u6d88"], "Edit": ["\u7f16\u8f91"], "OK": ["\u786e\u5b9a"], "Apply": ["\u5e94\u7528"], "WARNING: Could not save invalid JSON.": ["\u8b66\u544a: \u4e0d\u80fd\u4fdd\u5b58\u65e0\u6548\u7684JSON\u3002"], "There are no attachments for this cell.": ["\u8fd9\u4e2a\u5757\u6ca1\u6709\u9644\u4ef6\u3002"], "Current cell attachments": ["\u5f53\u524d\u5757\u9644\u4ef6"], "Attachments": ["\u9644\u4ef6"], "Restore": ["\u91cd\u65b0\u4fdd\u5b58"], "Delete": ["\u5220\u9664"], "Edit attachments": ["\u7f16\u8f91\u9644\u4ef6"], "Edit Notebook Attachments": ["\u7f16\u8f91\u7b14\u8bb0\u672c\u9644\u4ef6"], "Edit Cell Attachments": ["\u7f16\u8f91\u5757\u9644\u4ef6"], "Select a file to insert.": ["\u9009\u62e9\u6587\u4ef6\u63d2\u5165"], "Select a file": ["\u9009\u62e9\u6587\u4ef6"], "You are using Jupyter notebook.": ["\u60a8\u6b63\u5728\u4f7f\u7528 Jupyter Notebook\u3002"], "The version of the notebook server is: ": ["\u8be5 notebook \u670d\u52a1\u7684\u7248\u672c\u662f\uff1a"], "The server is running on this version of Python:": ["\u8be5\u670d\u52a1\u8fd0\u884c\u4e2d\u4f7f\u7528\u7684 Python \u7248\u672c\u4e3a:"], "Waiting for kernel to be available...": ["\u7b49\u5f85\u5185\u6838\u53ef\u7528..."], "Server Information:": ["\u670d\u52a1\u4fe1\u606f:"], "Current Kernel Information:": ["\u5f53\u524d\u5185\u6838\u4fe1\u606f:"], "Could not access sys_info variable for version information.": ["\u65e0\u6cd5\u8bbf\u95ee sys_info \u53d8\u91cf\u6765\u83b7\u53d6\u7248\u672c\u4fe1\u606f\u3002"], "Cannot find sys_info!": ["\u627e\u4e0d\u5230 sys_info\uff01"], "About Jupyter Notebook": ["\u5173\u4e8e Jupyter Notebook"], "unable to contact kernel": ["\u4e0d\u80fd\u8fde\u63a5\u5230\u5185\u6838"], "toggle rtl layout": ["\u5207\u6362 RTL \u5e03\u5c40"], "Toggle the screen directionality between left-to-right and right-to-left": ["\u5207\u6362\u5de6\u81f3\u53f3\u6216\u53f3\u81f3\u5de6\u7684\u5c4f\u5e55\u65b9\u5411"], "edit command mode keyboard shortcuts": ["\u7f16\u8f91\u547d\u4ee4\u6a21\u5f0f\u952e\u76d8\u5feb\u6377\u952e"], "Open a dialog to edit the command mode keyboard shortcuts": ["\u6253\u5f00\u7a97\u53e3\u6765\u7f16\u8f91\u5feb\u6377\u952e"], "restart kernel": ["\u91cd\u542f\u5185\u6838"], "restart the kernel (no confirmation dialog)": ["\u91cd\u542f\u5185\u6838\uff08\u65e0\u786e\u8ba4\u5bf9\u8bdd\u6846\uff09"], "confirm restart kernel": ["\u786e\u5b9a\u91cd\u542f\u5185\u6838"], "restart the kernel (with dialog)": ["\u91cd\u542f\u5185\u6838\uff08\u5e26\u786e\u8ba4\u5bf9\u8bdd\u6846\uff09"], "restart kernel and run all cells": ["\u91cd\u542f\u5185\u6838\u5e76\u4e14\u8fd0\u884c\u6240\u6709\u4ee3\u7801\u5757"], "restart the kernel, then re-run the whole notebook (no confirmation dialog)": ["\u91cd\u542f\u670d\u52a1\uff0c\u7136\u540e\u91cd\u65b0\u8fd0\u884c\u6574\u4e2a\u7b14\u8bb0\u672c\uff08\u65e0\u786e\u8ba4\u5bf9\u8bdd\u6846\uff09"], "confirm restart kernel and run all cells": ["\u786e\u8ba4\u91cd\u542f\u5185\u6838\u5e76\u4e14\u8fd0\u884c\u6240\u6709\u4ee3\u7801\u5757"], "restart the kernel, then re-run the whole notebook (with dialog)": ["\u91cd\u542f\u5185\u6838, \u7136\u540e\u91cd\u65b0\u8fd0\u884c\u6574\u4e2a\u4ee3\u7801\uff08\u5e26\u786e\u8ba4\u5bf9\u8bdd\u6846\uff09"], "restart kernel and clear output": ["\u91cd\u542f\u5185\u6838\u5e76\u4e14\u6e05\u7a7a\u8f93\u51fa"], "restart the kernel and clear all output (no confirmation dialog)": ["\u91cd\u542f\u5185\u6838\u5e76\u4e14\u6e05\u7a7a\u6240\u6709\u8f93\u51fa\uff08\u65e0\u786e\u8ba4\u5bf9\u8bdd\u6846\uff09"], "confirm restart kernel and clear output": ["\u786e\u8ba4\u91cd\u542f\u5185\u6838\u5e76\u4e14\u6e05\u7a7a\u8f93\u51fa"], "restart the kernel and clear all output (with dialog)": ["\u91cd\u542f\u5185\u6838\u5e76\u4e14\u6e05\u7a7a\u6240\u6709\u8f93\u51fa\uff08\u5e26\u786e\u8ba4\u5bf9\u8bdd\u6846\uff09"], "interrupt the kernel": ["\u4e2d\u65ad\u5185\u6838"], "run cell and select next": ["\u8fd0\u884c\u4ee3\u7801\u5757\u5e76\u4e14\u9009\u62e9\u4e0b\u4e00\u4e2a\u4ee3\u7801\u5757"], "run cell, select below": ["\u8fd0\u884c\u4ee3\u7801\u5757, \u9009\u62e9\u4e0b\u9762\u7684\u4ee3\u7801\u5757"], "run selected cells": ["\u8fd0\u884c\u9009\u4e2d\u7684\u4ee3\u7801\u5757"], "run cell and insert below": ["\u8fd0\u884c\u4ee3\u7801\u5757\u5e76\u4e14\u5728\u4e0b\u9762\u63d2\u5165\u4ee3\u7801\u5757"], "run all cells": ["\u8fd0\u884c\u6240\u6709\u7684\u4ee3\u7801\u5757"], "run all cells above": ["\u8fd0\u884c\u4e0a\u9762\u6240\u6709\u7684\u4ee3\u7801\u5757"], "run all cells below": ["\u8fd0\u884c\u4e0b\u9762\u6240\u6709\u7684\u4ee3\u7801\u5757"], "enter command mode": ["\u8fdb\u5165\u547d\u4ee4\u884c\u6a21\u5f0f"], "insert image": ["\u63d2\u5165\u56fe\u7247"], "cut cell attachments": ["\u526a\u5207\u4ee3\u7801\u5757\u7684\u9644\u4ef6"], "copy cell attachments": ["\u590d\u5236\u4ee3\u7801\u5757\u7684\u9644\u4ef6"], "paste cell attachments": ["\u7c98\u8d34\u4ee3\u7801\u5757\u7684\u9644\u4ef6"], "split cell at cursor": ["\u5728\u5149\u6807\u5904\u5206\u5272\u4ee3\u7801\u5757"], "enter edit mode": ["\u8fdb\u5165\u7f16\u8f91\u6a21\u5f0f"], "select previous cell": ["\u9009\u62e9\u4e0a\u4e00\u4e2a\u4ee3\u7801\u5757"], "select cell above": ["\u9009\u62e9\u4e0a\u9762\u7684\u4ee3\u7801\u5757"], "select next cell": ["\u9009\u62e9\u4e0b\u4e00\u4e2a\u4ee3\u7801\u5757"], "select cell below": ["\u9009\u62e9\u4e0b\u9762\u7684\u4ee3\u7801\u5757"], "extend selection above": ["\u6269\u5c55\u4e0a\u9762\u7684\u4ee3\u7801\u5757"], "extend selected cells above": ["\u6269\u5c55\u4e0a\u9762\u9009\u62e9\u7684\u4ee3\u7801\u5757"], "extend selection below": ["\u6269\u5c55\u4e0b\u9762\u7684\u4ee3\u7801\u5757"], "extend selected cells below": ["\u6269\u5c55\u4e0b\u9762\u9009\u62e9\u7684\u4ee3\u7801\u5757"], "cut selected cells": ["\u526a\u5207\u9009\u62e9\u7684\u4ee3\u7801\u5757"], "copy selected cells": ["\u590d\u5236\u9009\u62e9\u7684\u4ee3\u7801\u5757"], "paste cells above": ["\u7c98\u8d34\u5230\u4e0a\u9762"], "paste cells below": ["\u7c98\u8d34\u5230\u4e0b\u9762"], "insert cell above": ["\u5728\u4e0a\u9762\u63d2\u5165\u4ee3\u7801\u5757"], "insert cell below": ["\u5728\u4e0b\u9762\u63d2\u5165\u4ee3\u7801\u5757"], "change cell to code": ["\u628a\u4ee3\u7801\u5757\u53d8\u6210\u4ee3\u7801"], "change cell to markdown": ["\u628a\u4ee3\u7801\u5757\u53d8\u6210 Markdown"], "change cell to raw": ["\u6e05\u9664\u4ee3\u7801\u5757\u683c\u5f0f"], "change cell to heading 1": ["\u628a\u4ee3\u7801\u5757\u53d8\u6210\u6807\u9898 1"], "change cell to heading 2": ["\u628a\u4ee3\u7801\u5757\u53d8\u6210\u6807\u9898 2"], "change cell to heading 3": ["\u628a\u4ee3\u7801\u5757\u53d8\u6210\u6807\u9898 3"], "change cell to heading 4": ["\u628a\u4ee3\u7801\u5757\u53d8\u6210\u6807\u9898 4"], "change cell to heading 5": ["\u628a\u4ee3\u7801\u5757\u53d8\u6210\u6807\u9898 5"], "change cell to heading 6": ["\u628a\u4ee3\u7801\u5757\u53d8\u6210\u6807\u9898 6"], "toggle cell output": ["\u5207\u6362\u4ee3\u7801\u5757\u8f93\u51fa"], "toggle output of selected cells": ["\u5207\u6362\u9009\u5b9a\u5355\u5143\u683c\u7684\u8f93\u51fa"], "toggle cell scrolling": ["\u5207\u6362\u5355\u5143\u683c\u6eda\u52a8"], "toggle output scrolling of selected cells": ["\u5207\u6362\u9009\u4e2d\u5355\u5143\u683c\u7684\u8f93\u51fa\u6eda\u52a8"], "clear cell output": ["\u6e05\u7a7a\u6240\u6709\u5355\u5143\u683c\u8f93\u51fa"], "clear output of selected cells": ["\u6e05\u7a7a\u5df2\u9009\u62e9\u5355\u5143\u683c\u7684\u8f93\u51fa"], "move cells down": ["\u4e0b\u79fb"], "move selected cells down": ["\u4e0b\u79fb\u9009\u4e2d\u5355\u5143\u683c"], "move cells up": ["\u4e0a\u79fb"], "move selected cells up": ["\u4e0a\u79fb\u9009\u4e2d\u5355\u5143\u683c"], "toggle line numbers": ["\u5207\u6362\u884c\u53f7"], "show keyboard shortcuts": ["\u663e\u793a\u952e\u76d8\u5feb\u6377\u952e"], "delete cells": ["\u5220\u9664\u5355\u5143\u683c"], "delete selected cells": ["\u5220\u9664\u9009\u4e2d\u5355\u5143\u683c"], "undo cell deletion": ["\u64a4\u9500\u5220\u9664"], "merge cell with previous cell": ["\u5408\u5e76\u4e0a\u4e00\u4e2a\u5355\u5143\u683c"], "merge cell above": ["\u5408\u5e76\u4e0a\u9762\u7684\u5355\u5143\u683c"], "merge cell with next cell": ["\u5408\u5e76\u4e0b\u4e00\u4e2a\u5355\u5143\u683c"], "merge cell below": ["\u5408\u5e76\u4e0b\u9762\u7684\u5355\u5143\u683c"], "merge selected cells": ["\u5408\u5e76\u9009\u4e2d\u7684\u5355\u5143\u683c"], "merge cells": ["\u5408\u5e76\u5355\u5143\u683c"], "merge selected cells, or current cell with cell below if only one cell is selected": ["\u5408\u5e76\u9009\u4e2d\u5355\u5143\u683c, \u5982\u679c\u53ea\u6709\u4e00\u4e2a\u5355\u5143\u683c\u88ab\u9009\u4e2d"], "show command pallette": ["\u663e\u793a\u547d\u4ee4\u914d\u7f6e"], "open the command palette": ["\u6253\u5f00\u547d\u4ee4\u914d\u7f6e"], "toggle all line numbers": ["\u5207\u6362\u6240\u6709\u884c\u53f7"], "toggles line numbers in all cells, and persist the setting": ["\u5728\u6240\u6709\u5355\u5143\u683c\u4e2d\u5207\u6362\u884c\u53f7\uff0c\u5e76\u4fdd\u6301\u8bbe\u7f6e"], "show all line numbers": ["\u663e\u793a\u884c\u53f7"], "show line numbers in all cells, and persist the setting": ["\u5728\u6240\u6709\u5355\u5143\u683c\u4e2d\u663e\u793a\u884c\u53f7\uff0c\u5e76\u4fdd\u6301\u8bbe\u7f6e"], "hide all line numbers": ["\u9690\u85cf\u884c\u53f7"], "hide line numbers in all cells, and persist the setting": ["\u9690\u85cf\u884c\u53f7\u5e76\u4fdd\u6301\u8bbe\u7f6e"], "toggle header": ["\u5207\u6362\u6807\u9898"], "switch between showing and hiding the header": ["\u5207\u6362\u663e\u793a\u548c\u9690\u85cf\u6807\u9898"], "show the header": ["\u663e\u793a\u6807\u9898"], "hide the header": ["\u9690\u85cf\u6807\u9898"], "toggle toolbar": ["\u5207\u6362\u5de5\u5177\u680f"], "switch between showing and hiding the toolbar": ["\u5207\u6362\u663e\u793a/\u9690\u85cf\u5de5\u5177\u680f"], "show the toolbar": ["\u663e\u793a\u5de5\u5177\u680f"], "hide the toolbar": ["\u9690\u85cf\u5de5\u5177\u680f"], "close the pager": ["\u5173\u95ed\u5206\u9875\u5668"], "ignore": ["\u5ffd\u7565"], "move cursor up": ["\u5149\u6807\u4e0a\u79fb"], "move cursor down": ["\u5149\u6807\u4e0b\u79fb"], "scroll notebook down": ["\u5411\u4e0b\u6eda\u52a8"], "scroll notebook up": ["\u5411\u4e0a\u6eda\u52a8"], "scroll cell center": ["\u6eda\u52a8\u5355\u5143\u683c\u5230\u4e2d\u95f4"], "Scroll the current cell to the center": ["\u628a\u5f53\u524d\u5355\u5143\u683c\u6eda\u52a8\u5230\u4e2d\u95f4"], "scroll cell top": ["\u6eda\u52a8\u5355\u5143\u683c\u5230\u9876"], "Scroll the current cell to the top": ["\u5c06\u5f53\u524d\u5355\u5143\u683c\u6eda\u52a8\u5230\u9876\u90e8"], "duplicate notebook": ["\u5236\u4f5c\u7b14\u8bb0\u672c\u526f\u672c"], "Create and open a copy of the current notebook": ["\u521b\u5efa\u5e76\u6253\u5f00\u5f53\u524d\u7b14\u8bb0\u672c\u7684\u4e00\u4e2a\u526f\u672c"], "trust notebook": ["\u4fe1\u4efb\u7b14\u8bb0\u672c"], "Trust the current notebook": ["\u4fe1\u4efb\u5f53\u524d\u7b14\u8bb0\u672c"], "rename notebook": ["\u91cd\u547d\u540d\u7b14\u8bb0\u672c"], "Rename the current notebook": ["\u91cd\u547d\u540d\u5f53\u524d\u7b14\u8bb0\u672c"], "toggle all cells output collapsed": ["\u5207\u6362\u6298\u53e0\u6240\u6709\u5355\u5143\u683c\u7684\u8f93\u51fa"], "Toggle the hidden state of all output areas": ["\u5207\u6362\u6240\u6709\u8f93\u51fa\u533a\u57df\u7684\u9690\u85cf\u72b6\u6001"], "toggle all cells output scrolled": ["\u5207\u6362\u6240\u6709\u5355\u5143\u683c\u8f93\u51fa\u7684\u6eda\u52a8\u72b6\u6001"], "Toggle the scrolling state of all output areas": ["\u5207\u6362\u6240\u6709\u8f93\u51fa\u533a\u57df\u7684\u6eda\u52a8\u72b6\u6001"], "clear all cells output": ["\u6e05\u7a7a\u6240\u6709\u5355\u5143\u683c\u8f93\u51fa"], "Clear the content of all the outputs": ["\u6e05\u7a7a\u6240\u6709\u7684\u8f93\u51fa\u5185\u5bb9"], "save notebook": ["\u4fdd\u5b58\u7b14\u8bb0\u672c"], "Save and Checkpoint": ["\u4fdd\u5b58\u5e76\u5efa\u7acb\u68c0\u67e5\u70b9"], "Warning: accessing Cell.cm_config directly is deprecated.": ["\u8b66\u544a: \u76f4\u63a5\u8bbf\u95ee Cell.cm_config \u5df2\u7ecf\u88ab\u5f03\u7528\u4e86\u3002"], "Unrecognized cell type: %s": ["\u672a\u77e5\u7684\u5355\u5143\u683c\u7c7b\u578b: %s"], "Unrecognized cell type": ["\u672a\u77e5\u7684\u5355\u5143\u683c\u7c7b\u578b"], "Error in cell toolbar callback %s": ["\u5de5\u5177\u680f\u8c03\u7528 %s \u51fa\u73b0\u9519\u8bef"], "Clipboard types: %s": ["\u526a\u8d34\u677f\u7c7b\u578b: %s"], "Dialog for paste from system clipboard": ["\u4ece\u7cfb\u7edf\u526a\u5207\u677f\u7c98\u8d34"], "Ctrl-V": [""], "Cmd-V": [""], "Press %s again to paste": ["\u518d\u6309\u4e00\u6b21 %s \u6765\u7c98\u8d34"], "Why is this needed? ": ["\u4e3a\u4ec0\u4e48\u9700\u8981\u5b83?"], "We can't get paste events in this browser without a text box. ": ["\u5728\u6d4f\u89c8\u5668\u91cc\u6ca1\u6709\u6587\u672c\u6846\u6211\u4eec\u4e0d\u80fd\u7c98\u8d34. "], "There's an invisible text box focused in this dialog.": ["\u5728\u8fd9\u4e2a\u5bf9\u8bdd\u6846\u4e2d\u6709\u4e00\u4e2a\u4e0d\u53ef\u89c1\u7684\u6587\u672c\u6846."], "%s to paste": ["%s \u6765\u7c98\u8d34"], "Can't execute cell since kernel is not set.": ["\u5f53\u524d\u4e0d\u80fd\u6267\u884c\u5355\u5143\u683c\u4ee3\u7801\uff0c\u56e0\u4e3a\u5185\u6838\u8fd8\u6ca1\u6709\u51c6\u5907\u597d\u3002"], "In": [""], "Could not find a kernel matching %s. Please select a kernel:": ["\u627e\u4e0d\u5230\u5339\u914d %s \u7684\u5185\u6838\u3002\u8bf7\u9009\u62e9\u4e00\u4e2a\u5185\u6838:"], "Continue Without Kernel": ["\u65e0\u5185\u6838\u7ee7\u7eed\u8fd0\u884c"], "Set Kernel": ["\u8bbe\u7f6e\u5185\u6838"], "Kernel not found": ["\u627e\u4e0d\u5230\u5185\u6838"], "Creating Notebook Failed": ["\u521b\u5efa\u7b14\u8bb0\u672c\u5931\u8d25"], "The error was: %s": ["\u9519\u8bef\uff1a %s"], "Run": ["\u8fd0\u884c"], "Code": ["\u4ee3\u7801"], "Markdown": ["Markdown"], "Raw NBConvert": ["\u539f\u751f NBConvert"], "Heading": ["\u6807\u9898"], "unrecognized cell type:": ["\u672a\u8bc6\u522b\u7684\u5355\u5143\u683c\u7c7b\u578b\uff1a"], "Failed to retrieve MathJax from '%s'": ["\u672a\u80fd\u4ece '%s' \u4e2d\u68c0\u7d22 MathJax"], "Math/LaTeX rendering will be disabled.": ["Math/LaTeX \u6e32\u67d3\u5c06\u88ab\u7981\u7528\u3002"], "Trusted Notebook": ["\u53ef\u4fe1\u7684\u7b14\u8bb0\u672c"], "Trust Notebook": ["\u4fe1\u4efb\u7b14\u8bb0\u672c"], "None": ["\u65e0"], "No checkpoints": ["\u6ca1\u6709\u68c0\u67e5\u70b9"], "Opens in a new window": ["\u5728\u65b0\u7a97\u53e3\u6253\u5f00"], "Autosave in progress, latest changes may be lost.": ["\u81ea\u52a8\u4fdd\u5b58\u8fdb\u884c\u4e2d\uff0c\u6700\u65b0\u7684\u6539\u53d8\u53ef\u80fd\u4f1a\u4e22\u5931\u3002"], "Unsaved changes will be lost.": ["\u672a\u4fdd\u5b58\u7684\u4fee\u6539\u5c06\u4f1a\u4e22\u5931\u3002"], "The Kernel is busy, outputs may be lost.": ["\u5185\u6838\u6b63\u5fd9\uff0c\u8f93\u51fa\u4e5f\u8bb8\u4f1a\u4e22\u5931\u3002"], "This notebook is version %1$s, but we only fully support up to %2$s.": ["\u8be5\u7b14\u8bb0\u672c\u4f7f\u7528\u4e86\u7248\u672c %1$s\uff0c\u4f46\u662f\u6211\u4eec\u53ea\u652f\u6301\u5230 %2$s."], "You can still work with this notebook, but cell and output types introduced in later notebook versions will not be available.": ["\u60a8\u4ecd\u7136\u53ef\u4ee5\u4f7f\u7528\u8be5\u7b14\u8bb0\u672c\uff0c\u4f46\u662f\u5728\u65b0\u7248\u672c\u4e2d\u5f15\u5165\u7684\u5355\u5143\u548c\u8f93\u51fa\u7c7b\u578b\u5c06\u4e0d\u53ef\u7528\u3002"], "Restart and Run All Cells": ["\u91cd\u542f\u5e76\u8fd0\u884c\u6240\u6709\u4ee3\u7801\u5757"], "Restart and Clear All Outputs": ["\u91cd\u542f\u5e76\u6e05\u7a7a\u6240\u6709\u8f93\u51fa"], "Restart": ["\u91cd\u542f"], "Continue Running": ["\u7ee7\u7eed\u8fd0\u884c"], "Reload": ["\u91cd\u8f7d"], "Overwrite": ["\u91cd\u5199"], "Trust": ["\u4fe1\u4efb"], "Revert": ["\u6062\u590d"], "Newer Notebook": ["\u65b0\u7b14\u8bb0\u672c"], "Use markdown headings": ["\u4f7f\u7528 Markdown \u6807\u9898"], "Jupyter no longer uses special heading cells. Instead, write your headings in Markdown cells using # characters:": ["Jupyter \u4e0d\u518d\u4f7f\u7528\u7279\u6b8a\u7684\u6807\u9898\u5355\u5143\u683c\u3002\u8bf7\u5728 Markdown \u5355\u5143\u683c\u4e2d\u4f7f\u7528 # \u5b57\u7b26\u6765\u5199\u6807\u9898\uff1a"], "## This is a level 2 heading": ["## \u8fd9\u662f\u4e00\u4e2a\u4e8c\u7ea7\u6807\u9898"], "Restart kernel and re-run the whole notebook?": ["\u91cd\u65b0\u542f\u52a8\u5185\u6838\u5e76\u91cd\u65b0\u8fd0\u884c\u6574\u4e2a\u7b14\u8bb0\u672c\uff1f"], "Are you sure you want to restart the current kernel and re-execute the whole notebook?  All variables and outputs will be lost.": ["\u60a8\u786e\u5b9a\u8981\u91cd\u65b0\u542f\u52a8\u5f53\u524d\u7684\u5185\u6838\u5e76\u91cd\u65b0\u6267\u884c\u6574\u4e2a\u7b14\u8bb0\u672c\u5417\uff1f\u6240\u6709\u7684\u53d8\u91cf\u548c\u8f93\u51fa\u90fd\u5c06\u4e22\u5931\u3002"], "Restart kernel and clear all output?": ["\u91cd\u542f\u5185\u6838\u5e76\u4e14\u6e05\u7a7a\u8f93\u51fa\uff1f"], "Do you want to restart the current kernel and clear all output?  All variables and outputs will be lost.": ["\u60a8\u662f\u5426\u5e0c\u671b\u91cd\u65b0\u542f\u52a8\u5f53\u524d\u7684\u5185\u6838\u5e76\u6e05\u9664\u6240\u6709\u8f93\u51fa\uff1f\u6240\u6709\u7684\u53d8\u91cf\u548c\u8f93\u51fa\u90fd\u5c06\u4e22\u5931\u3002"], "Restart kernel?": ["\u91cd\u542f\u5185\u6838\uff1f"], "Do you want to restart the current kernel?  All variables will be lost.": ["\u5982\u679c\u91cd\u542f\u5185\u6838\uff0c\u6240\u6709\u53d8\u91cf\u90fd\u4f1a\u4e22\u5931\u3002\u662f\u5426\u91cd\u542f\uff1f"], "Shutdown kernel?": ["\u5173\u95ed\u5185\u6838\uff1f"], "Do you want to shutdown the current kernel?  All variables will be lost.": ["\u5982\u679c\u5173\u95ed\u5185\u6838\uff0c\u6240\u6709\u53d8\u91cf\u90fd\u4f1a\u4e22\u5931\u3002\u662f\u5426\u5173\u95ed\uff1f"], "Notebook changed": ["\u7b14\u8bb0\u672c\u6539\u53d8\u4e86"], "The notebook file has changed on disk since the last time we opened or saved it. Do you want to overwrite the file on disk with the version open here, or load the version on disk (reload the page)?": ["\u81ea\u4ece\u4e0a\u6b21\u6211\u4eec\u6253\u5f00\u6216\u4fdd\u5b58\u5b83\u4ee5\u6765\uff0c\u7b14\u8bb0\u672c\u6587\u4ef6\u5df2\u7ecf\u5728\u78c1\u76d8\u4e0a\u53d1\u751f\u4e86\u53d8\u5316\u3002\u60a8\u5e0c\u671b\u7528\u8fd9\u91cc\u6253\u5f00\u7684\u7248\u672c\u8986\u76d6\u78c1\u76d8\u4e0a\u7684\u7248\u672c\uff0c\u8fd8\u662f\u52a0\u8f7d\u78c1\u76d8\u4e0a\u7684\u7248\u672c\uff08\u5237\u65b0\u9875\u9762\uff09\uff1f"], "Notebook validation failed": ["Notebook \u6821\u9a8c\u5931\u8d25"], "The save operation succeeded, but the notebook does not appear to be valid. The validation error was:": ["\u4fdd\u5b58\u64cd\u4f5c\u6210\u529f\u4e86\uff0c\u4f46\u662f\u8fd9\u4e2a\u7b14\u8bb0\u672c\u770b\u8d77\u6765\u5e76\u4e0d\u6709\u6548\u3002\u6821\u9a8c\u9519\u8bef\uff1a"], "A trusted Jupyter notebook may execute hidden malicious code when you open it. Selecting trust will immediately reload this notebook in a trusted state. For more information, see the Jupyter security documentation: ": ["\u5f53\u4f60\u6253\u5f00\u4e00\u4e2a\u53ef\u4fe1\u4efb\u7684 Jupyter \u7b14\u8bb0\u672c\u65f6\uff0c\u5b83\u53ef\u80fd\u4f1a\u6267\u884c\u9690\u85cf\u7684\u6076\u610f\u4ee3\u7801\u3002\u9009\u62e9\u4fe1\u4efb\u5c06\u7acb\u5373\u5728\u4e00\u4e2a\u53ef\u4fe1\u7684\u72b6\u6001\u4e2d\u91cd\u65b0\u52a0\u8f7d\u8fd9\u4e2a\u7b14\u8bb0\u672c\u3002\u8981\u4e86\u89e3\u66f4\u591a\u4fe1\u606f\uff0c\u8bf7\u53c2\u9605 Jupyter \u5b89\u5168\u6587\u6863\uff1a"], "here": ["\u8fd9\u91cc"], "Trust this notebook?": ["\u4fe1\u4efb\u8fd9\u4e2a\u7b14\u8bb0\u672c\uff1f"], "Notebook failed to load": ["\u7b14\u8bb0\u672c\u52a0\u8f7d\u5931\u8d25"], "The error was: ": ["\u9519\u8bef: "], "See the error console for details.": ["\u6709\u5173\u8be6\u7ec6\u4fe1\u606f\uff0c\u8bf7\u53c2\u9605\u9519\u8bef\u63a7\u5236\u53f0\u3002"], "The notebook also failed validation:": ["\u8fd9\u4e2a\u7b14\u8bb0\u672c\u6821\u9a8c\u4e5f\u5931\u8d25\u4e86:"], "An invalid notebook may not function properly. The validation error was:": ["\u65e0\u6548\u7684\u7b14\u8bb0\u672c\u53ef\u80fd\u65e0\u6cd5\u6b63\u5e38\u8fd0\u884c\u3002\u6821\u9a8c\u9519\u8bef\uff1a"], "This notebook has been converted from an older notebook format to the current notebook format v(%s).": ["\u672c\u7b14\u8bb0\u672c\u5df2\u4ece\u8f83\u65e7\u7684\u7b14\u8bb0\u672c\u683c\u5f0f\u8f6c\u6362\u4e3a\u5f53\u524d\u7684\u7b14\u8bb0\u672c\u683c\u5f0f v(%s)\u3002"], "This notebook has been converted from a newer notebook format to the current notebook format v(%s).": ["\u8fd9\u4e2a\u7b14\u8bb0\u672c\u5df2\u7ecf\u4ece\u4e00\u79cd\u65b0\u7684\u7b14\u8bb0\u672c\u683c\u5f0f\u8f6c\u6362\u4e3a\u5f53\u524d\u7684\u7b14\u8bb0\u672c\u683c\u5f0f v(%s)\u3002"], "The next time you save this notebook, the current notebook format will be used.": ["\u4e0b\u6b21\u4f60\u4fdd\u5b58\u8fd9\u4e2a\u7b14\u8bb0\u672c\u65f6\uff0c\u5f53\u524d\u7684\u7b14\u8bb0\u672c\u683c\u5f0f\u5c06\u4f1a\u88ab\u4f7f\u7528\u3002"], "Older versions of Jupyter may not be able to read the new format.": ["\u65e7\u7248\u672c\u7684 Jupyter \u53ef\u80fd\u65e0\u6cd5\u8bfb\u53d6\u65b0\u683c\u5f0f\u3002"], "Some features of the original notebook may not be available.": ["\u539f\u7b14\u8bb0\u672c\u7684\u4e00\u4e9b\u7279\u6027\u53ef\u80fd\u65e0\u6cd5\u4f7f\u7528\u3002"], "To preserve the original version, close the notebook without saving it.": ["\u4e3a\u4e86\u4fdd\u5b58\u539f\u59cb\u7248\u672c\uff0c\u5173\u95ed\u7b14\u8bb0\u672c\u800c\u4e0d\u4fdd\u5b58\u5b83\u3002"], "Notebook converted": ["\u5df2\u8f6c\u6362\u7b14\u8bb0\u672c"], "(No name)": ["\uff08\u6ca1\u6709\u540d\u5b57\uff09"], "An unknown error occurred while loading this notebook. This version can load notebook formats %s or earlier. See the server log for details.": ["\u52a0\u8f7d\u672c\u7b14\u8bb0\u672c\u65f6\u51fa\u73b0\u4e86\u4e00\u4e2a\u672a\u77e5\u7684\u9519\u8bef\u3002\u8fd9\u4e2a\u7248\u672c\u53ef\u4ee5\u52a0\u8f7d %s \u6216\u66f4\u65e9\u7684\u7b14\u8bb0\u672c\u3002\u6709\u5173\u8be6\u7ec6\u4fe1\u606f\uff0c\u8bf7\u53c2\u9605\u670d\u52a1\u5668\u65e5\u5fd7\u3002"], "Error loading notebook": ["\u52a0\u8f7d\u7b14\u8bb0\u672c\u51fa\u9519"], "Are you sure you want to revert the notebook to the latest checkpoint?": ["\u786e\u5b9a\u5c06\u7b14\u8bb0\u672c\u6062\u590d\u81f3\u6700\u8fd1\u7684\u68c0\u67e5\u70b9\uff1f"], "This cannot be undone.": ["\u8be5\u64cd\u4f5c\u4e0d\u80fd\u88ab\u8fd8\u539f\u3002"], "The checkpoint was last updated at:": ["\u7b14\u8bb0\u672c\u7684\u6700\u65b0\u68c0\u67e5\u70b9\u66f4\u65b0\u4e8e\uff1a"], "Revert notebook to checkpoint": ["\u6062\u590d\u7b14\u8bb0\u672c\u81f3\u68c0\u67e5\u70b9"], "Edit Mode": ["\u7f16\u8f91\u6a21\u5f0f"], "Command Mode": ["\u547d\u4ee4\u6a21\u5f0f"], "Kernel Created": ["\u5185\u6838\u5df2\u521b\u5efa"], "Connecting to kernel": ["\u6b63\u5728\u8fde\u63a5\u5185\u6838"], "Not Connected": ["\u672a\u8fde\u63a5"], "click to reconnect": ["\u70b9\u51fb\u91cd\u8fde"], "Restarting kernel": ["\u91cd\u542f\u5185\u6838"], "Kernel Restarting": ["\u5185\u6838\u6b63\u5728\u91cd\u542f"], "The kernel appears to have died. It will restart automatically.": ["\u5185\u6838\u4f3c\u4e4e\u6302\u6389\u4e86\uff0c\u5b83\u5f88\u5feb\u5c06\u81ea\u52a8\u91cd\u542f\u3002"], "Dead kernel": ["\u6302\u6389\u7684\u5185\u6838"], "Kernel Dead": ["\u5185\u6838\u6302\u6389"], "Interrupting kernel": ["\u6b63\u5728\u4e2d\u65ad\u5185\u6838"], "No Connection to Kernel": ["\u6ca1\u6709\u8fde\u63a5\u5230\u5185\u6838"], "A connection to the notebook server could not be established. The notebook will continue trying to reconnect. Check your network connection or notebook server configuration.": ["\u65e0\u6cd5\u5efa\u7acb\u5230\u7b14\u8bb0\u672c\u670d\u52a1\u5668\u7684\u8fde\u63a5\u3002 \u6211\u4eec\u4f1a\u7ee7\u7eed\u5c1d\u8bd5\u91cd\u8fde\u3002\u8bf7\u68c0\u67e5\u7f51\u7edc\u8fde\u63a5\u8fd8\u6709\u670d\u52a1\u914d\u7f6e\u3002"], "Connection failed": ["\u8fde\u63a5\u5931\u8d25"], "No kernel": ["\u6ca1\u6709\u5185\u6838"], "Kernel is not running": ["\u5185\u6838\u6ca1\u6709\u8fd0\u884c"], "Don't Restart": ["\u4e0d\u8981\u91cd\u542f"], "Try Restarting Now": ["\u73b0\u5728\u5c1d\u8bd5\u91cd\u542f"], "The kernel has died, and the automatic restart has failed. It is possible the kernel cannot be restarted. If you are not able to restart the kernel, you will still be able to save the notebook, but running code will no longer work until the notebook is reopened.": ["\u5185\u6838\u5df2\u7ecf\u6b7b\u4ea1\uff0c\u81ea\u52a8\u91cd\u542f\u4e5f\u5931\u8d25\u4e86\u3002\u53ef\u80fd\u662f\u5185\u6838\u4e0d\u80fd\u91cd\u65b0\u542f\u52a8\u3002\u5982\u679c\u60a8\u4e0d\u80fd\u91cd\u65b0\u542f\u52a8\u5185\u6838\uff0c\u60a8\u4ecd\u7136\u80fd\u591f\u4fdd\u5b58\u7b14\u8bb0\u672c\uff0c\u4f46\u7b14\u8bb0\u672c\u8981\u91cd\u65b0\u6253\u5f00\u624d\u80fd\u8fd0\u884c\u4ee3\u7801\u3002"], "No Kernel": ["\u6ca1\u6709\u5185\u6838"], "Failed to start the kernel": ["\u542f\u52a8\u5185\u6838\u5931\u8d25"], "Kernel Busy": ["\u5185\u6838\u6b63\u5fd9"], "Kernel starting, please wait...": ["\u5185\u6838\u6b63\u5728\u542f\u52a8,\u8bf7\u7b49\u5f85..."], "Kernel Idle": ["\u5185\u6838\u7a7a\u95f2"], "Kernel ready": ["\u5185\u6838\u5c31\u7eea"], "Using kernel: ": ["\u4f7f\u7528\u5185\u6838\uff1a"], "Only candidate for language: %1$s was %2$s.": ["\u53ea\u652f\u6301\u8bed\u8a00\uff1a %1$s - %2$s."], "Loading notebook": ["\u52a0\u8f7d\u7b14\u8bb0\u672c"], "Notebook loaded": ["\u7b14\u8bb0\u672c\u5df2\u52a0\u8f7d"], "Saving notebook": ["\u4fdd\u5b58\u7b14\u8bb0\u672c"], "Notebook saved": ["\u7b14\u8bb0\u672c\u5df2\u4fdd\u5b58"], "Notebook save failed": ["\u7b14\u8bb0\u672c\u4fdd\u5b58\u5931\u8d25"], "Notebook copy failed": ["\u7b14\u8bb0\u672c\u590d\u5236\u5931\u8d25"], "Checkpoint created": ["\u68c0\u67e5\u70b9\u5df2\u521b\u5efa"], "Checkpoint failed": ["\u68c0\u67e5\u70b9\u521b\u5efa\u5931\u8d25"], "Checkpoint deleted": ["\u68c0\u67e5\u70b9\u5df2\u5220\u9664"], "Checkpoint delete failed": ["\u68c0\u67e5\u70b9\u5220\u9664\u5931\u8d25"], "Restoring to checkpoint...": ["\u6b63\u5728\u6062\u590d\u81f3\u68c0\u67e5\u70b9..."], "Checkpoint restore failed": ["\u68c0\u67e5\u70b9\u6062\u590d\u5931\u8d25"], "Autosave disabled": ["\u81ea\u52a8\u4fdd\u5b58\u5931\u8d25"], "Saving every %d sec.": ["\u6bcf\u9694 %s \u79d2\u4fdd\u5b58\u4e00\u6b21\u3002"], "Trusted": ["\u53ef\u4fe1"], "Not Trusted": ["\u4e0d\u53ef\u4fe1"], "click to expand output": ["\u70b9\u51fb\u5c55\u5f00\u8f93\u51fa"], "click to expand output; double click to hide output": ["\u70b9\u51fb\u5c55\u5f00\u8f93\u51fa\uff1b\u53cc\u51fb\u9690\u85cf\u8f93\u51fa"], "click to unscroll output; double click to hide": ["\u5355\u51fb\u53d6\u6d88\u6eda\u52a8\u8f93\u51fa\uff1b\u53cc\u51fb\u9690\u85cf"], "click to scroll output; double click to hide": ["\u70b9\u51fb\u6eda\u52a8\u8f93\u51fa\uff1b\u53cc\u51fb\u9690\u85cf"], "Javascript error adding output!": ["\u6dfb\u52a0\u8f93\u51fa\u65f6 Javascript \u51fa\u9519\u4e86\uff01"], "See your browser Javascript console for more details.": ["\u66f4\u591a\u7ec6\u8282\u8bf7\u53c2\u89c1\u60a8\u7684\u6d4f\u89c8\u5668 Javascript \u63a7\u5236\u53f0\u3002"], "Out[%d]:": [""], "Unrecognized output: %s": ["\u672a\u8bc6\u522b\u7684\u8f93\u51fa\uff1a %s"], "Open the pager in an external window": ["\u5728\u5916\u90e8\u7a97\u53e3\u6253\u5f00\u5206\u9875\u5668"], "Close the pager": ["\u5173\u95ed\u5206\u9875\u5668"], "Jupyter Pager": ["Jupyter \u5206\u9875\u5668"], "go to cell start": ["\u8df3\u5230\u5355\u5143\u683c\u8d77\u59cb\u5904"], "go to cell end": ["\u8df3\u5230\u5355\u5143\u683c\u6700\u540e"], "go one word left": ["\u5f80\u5de6\u8df3\u4e00\u4e2a\u5355\u8bcd"], "go one word right": ["\u5f80\u53f3\u8df3\u4e00\u4e2a\u5355\u8bcd"], "delete word before": ["\u5220\u9664\u524d\u9762\u7684\u5355\u8bcd"], "delete word after": ["\u5220\u9664\u540e\u9762\u7684\u5355\u8bcd"], "redo": ["\u91cd\u505a"], "redo selection": ["\u91cd\u65b0\u9009\u62e9"], "emacs-style line kill": ["Emacs \u98ce\u683c\u7684 Line Kill"], "delete line left of cursor": ["\u5220\u9664\u5149\u6807\u5de6\u8fb9\u4e00\u884c"], "delete line right of cursor": ["\u5220\u9664\u5149\u6807\u53f3\u8fb9\u4e00\u884c"], "code completion or indent": ["\u4ee3\u7801\u8865\u5168\u6216\u7f29\u8fdb"], "tooltip": ["\u5de5\u5177\u63d0\u793a"], "indent": ["\u7f29\u8fdb"], "dedent": ["\u53d6\u6d88\u7f29\u8fdb"], "select all": ["\u5168\u9009"], "undo": ["\u64a4\u9500"], "comment": ["\u6ce8\u91ca"], "delete whole line": ["\u5220\u9664\u6574\u884c"], "undo selection": ["\u64a4\u9500\u9009\u62e9"], "toggle overwrite flag": ["\u5207\u6362\u91cd\u5199\u6807\u5fd7"], "Shift": ["Shift"], "Alt": ["Alt"], "Up": ["\u4e0a"], "Down": ["\u4e0b"], "Left": ["\u5de6"], "Right": ["\u53f3"], "Tab": ["Tab"], "Caps Lock": ["\u5927\u5199\u9501\u5b9a"], "Esc": ["Esc"], "Ctrl": ["Ctrl"], "Enter": ["Enter"], "Page Up": ["\u4e0a\u4e00\u9875"], "Page Down": ["\u4e0b\u4e00\u9875"], "Home": ["Home"], "End": ["End"], "Space": ["\u7a7a\u683c"], "Backspace": ["\u9000\u683c"], "Minus": [""], "PageUp": ["\u4e0a\u4e00\u9875"], "The Jupyter Notebook has two different keyboard input modes.": ["Jupyter \u7b14\u8bb0\u672c\u6709\u4e24\u79cd\u4e0d\u540c\u7684\u952e\u76d8\u8f93\u5165\u6a21\u5f0f\u3002"], "<b>Edit mode</b> allows you to type code or text into a cell and is indicated by a green cell border.": ["<b>\u7f16\u8f91\u6a21\u5f0f</b>\u5141\u8bb8\u60a8\u5c06\u4ee3\u7801\u6216\u6587\u672c\u8f93\u5165\u5230\u4e00\u4e2a\u5355\u5143\u683c\u4e2d\uff0c\u5e76\u901a\u8fc7\u4e00\u4e2a\u7eff\u8272\u8fb9\u6846\u7684\u5355\u5143\u683c\u6765\u8868\u793a"], "<b>Command mode</b> binds the keyboard to notebook level commands and is indicated by a grey cell border with a blue left margin.": ["<b>\u547d\u4ee4\u6a21\u5f0f</b>\u5c06\u952e\u76d8\u4e0e\u7b14\u8bb0\u672c\u7ea7\u547d\u4ee4\u7ed1\u5b9a\u5728\u4e00\u8d77\uff0c\u5e76\u901a\u8fc7\u4e00\u4e2a\u7070\u6846\u3001\u5de6\u8fb9\u8ddd\u84dd\u8272\u7684\u5355\u5143\u683c\u663e\u793a\u3002"], "Close": ["\u5173\u95ed"], "Keyboard shortcuts": ["\u952e\u76d8\u5feb\u6377\u952e"], "Command": ["\u547d\u4ee4"], "Control": ["\u63a7\u5236"], "Option": ["\u9009\u9879"], "Return": ["\u8fd4\u56de"], "Command Mode (press %s to enable)": ["\u547d\u4ee4\u884c\u6a21\u5f0f\uff08\u6309 %s \u751f\u6548\uff09"], "Edit Shortcuts": ["\u7f16\u8f91\u5feb\u6377\u952e"], "edit command-mode keyboard shortcuts": ["\u7f16\u8f91\u547d\u4ee4\u6a21\u5f0f\u952e\u76d8\u5feb\u6377\u952e"], "Edit Mode (press %s to enable)": ["\u7f16\u8f91\u6a21\u5f0f\uff08\u6309 %s \u751f\u6548\uff09"], "Autosave Failed!": ["\u81ea\u52a8\u4fdd\u5b58\u5931\u8d25\uff01"], "Rename": ["\u91cd\u547d\u540d"], "Enter a new notebook name:": ["\u8bf7\u8f93\u5165\u65b0\u7684\u7b14\u8bb0\u672c\u540d\u79f0:"], "Rename Notebook": ["\u91cd\u547d\u540d\u7b14\u8bb0\u672c"], "Invalid notebook name. Notebook names must have 1 or more characters and can contain any characters except :/\\. Please enter a new notebook name:": ["\u65e0\u6548\u7684\u7b14\u8bb0\u672c\u540d\u79f0\u3002\u7b14\u8bb0\u672c\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\uff0c\u5e76\u4e14\u4e0d\u80fd\u5305\u542b\":/.\"\u3002\u8bf7\u8f93\u5165\u4e00\u4e2a\u65b0\u7684\u7b14\u8bb0\u672c\u540d\u79f0:"], "Renaming...": ["\u6b63\u5728\u91cd\u547d\u540d\u2026"], "Unknown error": ["\u672a\u77e5\u9519\u8bef"], "no checkpoint": ["\u6ca1\u6709\u68c0\u67e5\u70b9"], "Last Checkpoint: %s": ["\u6700\u65b0\u68c0\u67e5\u70b9: %s "], "(unsaved changes)": ["\uff08\u66f4\u6539\u672a\u4fdd\u5b58\uff09"], "(autosaved)": ["\uff08\u5df2\u81ea\u52a8\u4fdd\u5b58\uff09"], "Warning: too many matches (%d). Some changes might not be shown or applied.": ["\u8b66\u544a\uff1a\u592a\u591a\u7684\u5339\u914d(%d)\u3002\u6709\u4e9b\u66f4\u6539\u53ef\u80fd\u4e0d\u4f1a\u88ab\u663e\u793a\u6216\u5e94\u7528."], "%d match": ["%d \u5339\u914d", "%d \u5339\u914d"], "More than 100 matches, aborting": ["\u8d85\u8fc7 100 \u4e2a\u5339\u914d, \u4e2d\u6b62"], "Use regex (JavaScript regex syntax)": ["\u4f7f\u7528\u6b63\u5219\u8868\u8fbe\u5f0f\uff08JavaScript \u6b63\u5219\u8868\u8fbe\u5f0f\u8bed\u6cd5\uff09"], "Replace in selected cells": ["\u5728\u9009\u4e2d\u5355\u5143\u683c\u4e2d\u66ff\u6362"], "Match case": ["\u5339\u914d\u5927\u5c0f\u5199"], "Find": ["\u67e5\u627e"], "Replace": ["\u66ff\u6362"], "No matches, invalid or empty regular expression": ["\u65e0\u5339\u914d\uff0c\u8868\u8fbe\u5f0f\u65e0\u6548\u6216\u8868\u8fbe\u5f0f\u4e3a\u7a7a"], "Replace All": ["\u5168\u90e8\u66ff\u6362"], "Find and Replace": ["\u67e5\u627e\u5e76\u4e14\u66ff\u6362"], "find and replace": ["\u67e5\u627e\u5e76\u4e14\u66ff\u6362"], "Write raw LaTeX or other formats here, for use with nbconvert. It will not be rendered in the notebook. When passing through nbconvert, a Raw Cell's content is added to the output unmodified.": ["\u5728\u8fd9\u91cc\u76f4\u63a5\u5199 LaTeX \u6216\u8005\u5176\u5b83\u683c\u5f0f\u7684\u6587\u672c\u6765\u914d\u5408 nbconvert\u3002\u7b14\u8bb0\u672c\u4e0d\u4f1a\u6e32\u67d3\u5b83\u3002\u4f20\u7ed9 nbconvert \u65f6\uff0c\u539f\u59cb\u5355\u5143\u683c\u7684\u5185\u5bb9\u4f1a\u88ab\u5b8c\u597d\u5730\u52a0\u8fdb\u8f93\u51fa\u3002"], "Grow the tooltip vertically (press shift-tab twice)": ["\u7eb5\u5411\u5c55\u5f00\u5de5\u5177\u63d0\u793a\uff08\u6309\u4e24\u6b21 Shift+Tab\uff09"], "show the current docstring in pager (press shift-tab 4 times)": ["\u5728\u5206\u9875\u5668\u4e2d\u663e\u793a\u5f53\u524d\u7684\u6587\u6863\u5b57\u7b26\u4e32\uff08\u6309\u56db\u6b21 Shift+Tab\uff09"], "Open in Pager": ["\u5728\u5206\u9875\u5668\u4e2d\u6253\u5f00"], "Tooltip will linger for 10 seconds while you type": ["\u5f53\u60a8\u952e\u5165\u65f6\uff0c\u5de5\u5177\u63d0\u793a\u4f1a\u505c\u7559\u5341\u79d2"], "Welcome to the Notebook Tour": ["\u6b22\u8fce\u6765\u5230 Notebook \u5bfc\u89c8"], "You can use the left and right arrow keys to go backwards and forwards.": ["\u4f60\u53ef\u4ee5\u4f7f\u7528\u5de6\u53f3\u7bad\u5934\u952e\u6765\u524d\u540e\u79fb\u52a8"], "Filename": ["\u6587\u4ef6\u540d"], "Click here to change the filename for this notebook.": ["\u70b9\u51fb\u8fd9\u91cc\u4fee\u6539\u7b14\u8bb0\u672c\u7684\u6587\u4ef6\u540d"], "Notebook Menubar": ["\u7b14\u8bb0\u672c\u83dc\u5355\u680f"], "The menubar has menus for actions on the notebook, its cells, and the kernel it communicates with.": ["\u83dc\u5355\u680f\u4e0a\u7684\u83dc\u5355\u53ef\u4ee5\u7528\u6765\u64cd\u4f5c\u7b14\u8bb0\u672c\u3001\u5355\u5143\u683c\u548c\u4e0e\u7b14\u8bb0\u672c\u901a\u4fe1\u7684\u5185\u6838\u3002"], "Notebook Toolbar": ["\u7b14\u8bb0\u672c\u5de5\u5177\u680f"], "The toolbar has buttons for the most common actions. Hover your mouse over each button for more information.": ["\u5de5\u5177\u680f\u6709\u6700\u5e38\u89c1\u64cd\u4f5c\u7684\u6309\u94ae\u3002\u5c06\u9f20\u6807\u60ac\u505c\u5728\u6bcf\u4e2a\u6309\u94ae\u4e0a\u4ee5\u83b7\u5f97\u66f4\u591a\u4fe1\u606f\u3002"], "Mode Indicator": ["\u6a21\u5f0f\u6307\u793a\u5668"], "The Notebook has two modes: Edit Mode and Command Mode. In this area, an indicator can appear to tell you which mode you are in.": ["\u7b14\u8bb0\u672c\u6709\u4e24\u79cd\u6a21\u5f0f\uff1a\u7f16\u8f91\u6a21\u5f0f\u548c\u547d\u4ee4\u6a21\u5f0f\u3002\u5728\u8fd9\u4e2a\u533a\u57df\uff0c\u4e00\u4e2a\u6307\u793a\u5668\u53ef\u4ee5\u663e\u793a\u4f60\u5728\u54ea\u4e2a\u6a21\u5f0f\u3002"], "Right now you are in Command Mode, and many keyboard shortcuts are available. In this mode, no icon is displayed in the indicator area.": ["\u73b0\u5728\u4f60\u5904\u4e8e\u547d\u4ee4\u6a21\u5f0f\uff0c\u8bb8\u591a\u5feb\u6377\u952e\u90fd\u53ef\u4ee5\u4f7f\u7528\u3002\u5728\u8be5\u6a21\u5f0f\u4e0b\uff0c\u6307\u793a\u533a\u57df\u4e2d\u6ca1\u6709\u663e\u793a\u56fe\u6807\u3002"], "Pressing <code>Enter</code> or clicking in the input text area of the cell switches to Edit Mode.": ["\u6309\u4e0b<code>Enter</code>\u6216\u8005\u70b9\u51fb\u8f93\u5165\u6587\u672c\u533a\u57df\u6765\u5207\u6362\u5230\u7f16\u8f91\u6a21\u5f0f. "], "Notice that the border around the currently active cell changed color. Typing will insert text into the currently active cell.": ["\u60a8\u4f1a\u53d1\u73b0\u5f53\u524d\u6d3b\u52a8\u5355\u5143\u683c\u5468\u56f4\u7684\u8fb9\u6846\u6539\u53d8\u4e86\u989c\u8272\u3002\u952e\u5165\u5c06\u5728\u5f53\u524d\u6d3b\u52a8\u5355\u5143\u683c\u4e2d\u63d2\u5165\u6587\u672c."], "Back to Command Mode": ["\u56de\u5230\u547d\u4ee4\u6a21\u5f0f"], "Pressing <code>Esc</code> or clicking outside of the input text area takes you back to Command Mode.": ["\u6309\u4e0b<code>Esc</code>\u6216\u8005\u70b9\u51fb\u8f93\u5165\u6846\u5916\u9762\u6765\u8fd4\u56de\u5230\u547d\u4ee4\u6a21\u5f0f\u3002"], "Keyboard Shortcuts": ["\u952e\u76d8\u5feb\u6377\u952e"], "You can click here to get a list of all of the keyboard shortcuts.": ["\u70b9\u51fb\u8fd9\u91cc\u83b7\u5f97\u6240\u6709\u952e\u76d8\u5feb\u6377\u952e"], "Kernel Indicator": ["\u5185\u6838\u6307\u793a\u5668"], "This is the Kernel indicator. It looks like this when the Kernel is idle.": ["\u8fd9\u662f\u5185\u6838\u6307\u793a\u5668\u3002\u5f53\u5185\u6838\u7a7a\u95f2\u65f6\uff0c\u5b83\u770b\u8d77\u6765\u5c31\u50cf\u8fd9\u6837\u3002"], "The Kernel indicator looks like this when the Kernel is busy.": ["\u5185\u6838\u6307\u793a\u5668\u5728\u5185\u6838\u7e41\u5fd9\u65f6\u770b\u8d77\u6765\u662f\u8fd9\u6837\u7684\u3002"], "Interrupting the Kernel": ["\u5185\u6838\u4e2d\u65ad"], "To cancel a computation in progress, you can click here.": ["\u8981\u53d6\u6d88\u6b63\u5728\u8fdb\u884c\u7684\u8ba1\u7b97\u4efb\u52a1\uff0c\u60a8\u53ef\u4ee5\u70b9\u51fb\u8fd9\u91cc\u3002"], "Notification Area": ["\u4efb\u52a1\u680f\u901a\u77e5\u533a"], "Messages in response to user actions (Save, Interrupt, etc.) appear here.": ["\u54cd\u5e94\u7528\u6237\u64cd\u4f5c\uff08\u4fdd\u5b58\uff0c\u4e2d\u65ad\u7b49\uff09\u7684\u6d88\u606f\u51fa\u73b0\u5728\u8fd9\u91cc\u3002"], "End of Tour": ["\u7ed3\u675f\u5bfc\u89c8"], "This concludes the Jupyter Notebook User Interface Tour.": ["Jupyter \u7b14\u8bb0\u672c\u7528\u6237\u754c\u9762\u4e4b\u65c5\u5230\u6b64\u4e3a\u6b62\u3002"], "Edit Attachments": ["\u7f16\u8f91\u9644\u4ef6"], "Cell": ["\u5355\u5143\u683c"], "Edit Metadata": ["\u7f16\u8f91\u5143\u6570\u636e"], "Custom": ["\u81ea\u5b9a\u4e49"], "Set the MIME type of the raw cell:": ["\u8bbe\u7f6e\u539f\u59cb\u5355\u5143\u683c\u7684 MIME \u7c7b\u578b\uff1a"], "Raw Cell MIME Type": ["\u539f\u59cb\u5355\u5143\u683c\u7684 MIME \u7c7b\u578b"], "Raw NBConvert Format": ["\u539f\u59cb NBConvert \u7c7b\u578b"], "Raw Cell Format": ["\u539f\u59cb\u5355\u5143\u683c\u683c\u5f0f"], "Slide": ["\u5e7b\u706f\u7247"], "Sub-Slide": ["\u5b50\u5e7b\u706f\u7247"], "Fragment": ["\u788e\u7247"], "Skip": ["\u8df3\u8fc7"], "Notes": ["\u4ee3\u7801"], "Slide Type": ["\u5e7b\u706f\u7247\u7c7b\u578b"], "Slideshow": ["\u5e7b\u706f\u7247"], "Add tag": ["\u6dfb\u52a0\u6807\u7b7e"], "Edit the list of tags below. All whitespace is treated as tag separators.": ["\u7f16\u8f91\u4e0b\u9762\u7684\u6807\u7b7e\u5217\u8868\u3002\u6240\u6709\u7a7a\u683c\u90fd\u88ab\u5f53\u4f5c\u6807\u8bb0\u5206\u9694\u7b26\u3002"], "Edit the tags": ["\u7f16\u8f91\u6807\u7b7e"], "Edit Tags": ["\u7f16\u8f91\u6807\u7b7e"], "Shutdown": ["\u5173\u95ed"], "Create a new notebook with %s": ["\u521b\u5efa\u65b0\u7684\u7b14\u8bb0\u672c %s"], "An error occurred while creating a new notebook.": ["\u521b\u5efa\u65b0\u7b14\u8bb0\u672c\u65f6\u51fa\u9519\u3002"], "Creating File Failed": ["\u521b\u5efa\u6587\u4ef6\u5931\u8d25"], "An error occurred while creating a new file.": ["\u521b\u5efa\u65b0\u6587\u4ef6\u65f6\u51fa\u9519\u3002"], "Creating Folder Failed": ["\u521b\u5efa\u6587\u4ef6\u5939\u5931\u8d25"], "An error occurred while creating a new folder.": ["\u521b\u5efa\u65b0\u6587\u4ef6\u5939\u65f6\u51fa\u9519\u3002"], "Failed to read file": ["\u8bfb\u53d6\u6587\u4ef6\u5931\u8d25"], "Failed to read file %s": ["\u8bfb\u53d6\u6587\u4ef6 %s \u5931\u8d25\u4e86"], "The file size is %d MB. Do you still want to upload it?": ["\u6587\u4ef6\u5927\u5c0f\u4e3a %d MB\uff0c\u4f9d\u7136\u4e0a\u4f20?"], "Large file size warning": ["\u8bf7\u6ce8\u610f\u6587\u4ef6\u5927\u5c0f"], "Server error: ": ["\u670d\u52a1\u51fa\u73b0\u9519\u8bef\uff1a"], "The notebook list is empty.": ["\u7b14\u8bb0\u672c\u5217\u8868\u4e3a\u7a7a\u3002"], "Click here to rename, delete, etc.": ["\u70b9\u51fb\u8fd9\u91cc\u8fdb\u884c\u91cd\u547d\u540d\u6216\u5220\u9664\u7b49\u64cd\u4f5c"], "Running": ["\u8fd0\u884c"], "Enter a new file name:": ["\u8bf7\u8f93\u5165\u4e00\u4e2a\u65b0\u7684\u6587\u4ef6\u540d\uff1a"], "Enter a new directory name:": ["\u8bf7\u8f93\u5165\u4e00\u4e2a\u65b0\u7684\u8def\u5f84\uff1a"], "Enter a new name:": ["\u8bf7\u8f93\u5165\u65b0\u540d\u5b57\uff1a"], "Rename file": ["\u6587\u4ef6\u91cd\u547d\u540d"], "Rename directory": ["\u91cd\u547d\u540d\u8def\u5f84"], "Rename notebook": ["\u91cd\u547d\u540d\u7b14\u8bb0\u672c"], "Move": ["\u79fb\u52a8"], "An error occurred while renaming \"%1$s\" to \"%2$s\".": ["\u5f53\u628a \"%1$s\" \u91cd\u547d\u540d\u4e3a \"%2$s\" \u65f6\u51fa\u73b0\u9519\u8bef."], "Rename Failed": ["\u91cd\u547d\u540d\u5931\u8d25"], "Enter a new destination directory path for this item:": ["\u4e3a\u7b14\u8bb0\u672c\u9009\u62e9\u4e00\u4e2a\u65b0\u7684\u8def\u5f84\uff1a", "\u4e3a\u9009\u4e2d\u7684 %d \u7b14\u8bb0\u672c\u9009\u62e9\u4e00\u4e2a\u65b0\u7684\u8def\u5f84\uff1a"], "Move an Item": ["\u79fb\u52a8\u4e00\u4e2a\u6587\u4ef6", "\u79fb\u52a8 %d \u4e2a\u6587\u4ef6"], "An error occurred while moving \"%1$s\" from \"%2$s\" to \"%3$s\".": ["\u5f53\u628a \"%1$s\" \u4ece \"%2$s\" \u79fb\u52a8\u5230 \"%3$s\" \u65f6\u51fa\u73b0\u9519\u8bef."], "Move Failed": ["\u79fb\u52a8\u5931\u8d25"], "Are you sure you want to permanently delete: \"%s\"?": ["\u786e\u5b9a\u6c38\u4e45\u5220\u9664 \"%s\"?", "\u786e\u5b9a\u6c38\u4e45\u5220\u9664\u9009\u4e2d\u7684 %d \u4e2a\u6587\u4ef6\u6216\u6587\u4ef6\u5939?"], "An error occurred while deleting \"%s\".": ["\u5f53\u5220\u9664 \"%s\" \u65f6, \u51fa\u73b0\u9519\u8bef\u3002"], "Delete Failed": ["\u5220\u9664\u5931\u8d25"], "Are you sure you want to duplicate: \"%s\"?": ["\u786e\u5b9a\u5236\u4f5c \"%s\" \u7684\u526f\u672c\uff1f", "\u786e\u5b9a\u5236\u4f5c\u9009\u4e2d\u7684 %d \u4e2a\u6587\u4ef6\u7684\u526f\u672c?"], "Duplicate": ["\u5236\u4f5c\u526f\u672c"], "An error occurred while duplicating \"%s\".": ["\u5236\u4f5c \"%s\" \u7684\u526f\u672c\u65f6\u51fa\u73b0\u9519\u8bef\u3002"], "Duplicate Failed": ["\u5236\u4f5c\u526f\u672c\u5931\u8d25"], "Upload": ["\u4e0a\u4f20"], "Invalid file name": ["\u65e0\u6548\u7684\u6587\u4ef6\u540d"], "File names must be at least one character and not start with a period": ["\u6587\u4ef6\u540d\u4e0d\u80fd\u4e3a\u7a7a\uff0c\u5e76\u4e14\u4e0d\u80fd\u4ee5\u53e5\u53f7\u5f00\u59cb\uff0c\u9664\u4e0b\u5212\u7ebf\u4ee5\u5916\u7684\u7b26\u53f7\u90fd\u4e0d\u80fd\u5f00\u5934"], "Cannot upload invalid Notebook": ["\u65e0\u6cd5\u4e0a\u4f20\u65e0\u6548\u7684\u7b14\u8bb0\u672c"], "There is already a file named \"%s\". Do you want to replace it?": ["\u5df2\u7ecf\u5b58\u5728\u4e00\u4e2a\u540d\u4e3a \"%s\" \u7684\u6587\u4ef6\uff0c\u66ff\u6362\u73b0\u6709\u6587\u4ef6\uff1f"], "Replace file": ["\u66ff\u6362\u6587\u4ef6"]}}};
    document.documentElement.lang = navigator.language.toLowerCase();
    </script>

    
    

</head>

<body class="edit_app "
 
data-base-url="/lab/"
data-file-path="04-prefetch-check/solutions/01-prefetch-check-solution.cu"

  
    data-jupyter-api-token="945135f40226ea7b482873493c9cc894"
  
 

dir="ltr">

<noscript>
    <div id='noscript'>
      Jupyter Notebook requires JavaScript.<br>
      Please enable it to proceed. 
  </div>
</noscript>

<div id="header" role="navigation" aria-label="Top Menu">
  <div id="header-container" class="container">
  <div id="ipython_notebook" class="nav navbar-brand"><a href="/lab/notebooks/Streaming%20and%20Visual%20Profiling.ipynb?token=945135f40226ea7b482873493c9cc894" title='dashboard'>
      <img src='/lab/static/base/images/logo.png?v=a2a176ee3cee251ffddf5fa21fe8e43727a9e5f87a06f9c91ad7b776d9e9d3d5e0159c16cc188a3965e00375fb4bc336c16067c688f5040c0c2d4bfdb852a9e4' alt='Jupyter Notebook'/>
  </a></div>

  

<span id="save_widget" class="pull-left save_widget">
    <span class="filename"></span>
    <span class="last_modified"></span>
</span>


  

  
  
  
  

    <span id="login_widget">
      
        <button id="logout" class="btn btn-sm navbar-btn">Logout</button>
      
    </span>

  

  
  
  </div>
  <div class="header-bar"></div>

  

<div id="menubar-container" class="container">
  <div id="menubar">
    <div id="menus" class="navbar navbar-default" role="navigation">
      <div class="container-fluid">
          <p  class="navbar-text indicator_area">
          <span id="current-mode" >current mode</span>
          </p>
        <button type="button" class="btn btn-default navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <i class="fa fa-bars"></i>
          <span class="navbar-text">Menu</span>
        </button>
        <ul class="nav navbar-nav navbar-right">
          <li id="notification_area"></li>
        </ul>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">File</a>
              <ul id="file-menu" class="dropdown-menu">
                <li id="new-file"><a href="#">New</a></li>
                <li id="save-file"><a href="#">Save</a></li>
                <li id="rename-file"><a href="#">Rename</a></li>
                <li id="download-file"><a href="#">Download</a></li>
              </ul>
            </li>
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Edit</a>
              <ul id="edit-menu" class="dropdown-menu">
                <li id="menu-find"><a href="#">Find</a></li>
                <li id="menu-replace"><a href="#">Find &amp; Replace</a></li>
                <li class="divider"></li>
                <li class="dropdown-header">Key Map</li>
                <li id="menu-keymap-default"><a href="#">Default<i class="fa"></i></a></li>
                <li id="menu-keymap-sublime"><a href="#">Sublime Text<i class="fa"></i></a></li>
                <li id="menu-keymap-vim"><a href="#">Vim<i class="fa"></i></a></li>
                <li id="menu-keymap-emacs"><a href="#">emacs<i class="fa"></i></a></li>
              </ul>
            </li>
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">View</a>
              <ul id="view-menu" class="dropdown-menu">
              <li id="toggle_header" title="Show/Hide the logo and notebook title (above menu bar)">
              <a href="#">Toggle Header</a></li>
              <li id="menu-line-numbers"><a href="#">Toggle Line Numbers</a></li>
              </ul>
            </li>
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Language</a>
              <ul id="mode-menu" class="dropdown-menu">
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="lower-header-bar"></div>


</div>

<div id="site">


<div id="texteditor-backdrop">
<div id="texteditor-container" class="container"></div>
</div>


</div>






    


<script src="/lab/static/edit/js/main.min.js?v=6f6d31a2982c6ae99278e08d1164e4c3351c50aadcfd3a82d10948a6a7bf3d5ea2d16ac7c5fe1b307b95f045c952e54e743df229f16f3e4341ac33d330797ea6" type="text/javascript" charset="utf-8"></script>


<script type='text/javascript'>
  function _remove_token_from_url() {
    if (window.location.search.length <= 1) {
      return;
    }
    var search_parameters = window.location.search.slice(1).split('&');
    for (var i = 0; i < search_parameters.length; i++) {
      if (search_parameters[i].split('=')[0] === 'token') {
        // remote token from search parameters
        search_parameters.splice(i, 1);
        var new_search = '';
        if (search_parameters.length) {
          new_search = '?' + search_parameters.join('&');
        }
        var new_url = window.location.origin + 
                      window.location.pathname + 
                      new_search + 
                      window.location.hash;
        window.history.replaceState({}, "", new_url);
        return;
      }
    }
  }
  _remove_token_from_url();
</script>
</body>

</html>