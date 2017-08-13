/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 36);
/******/ })
/************************************************************************/
/******/ ({

/***/ 36:
/* exports provided: default */
/* all exports used */
/*!******************************************************************************!*\
  !*** ./app/javascript/packs/vue/static_pages/data_storage/about_sections.js ***!
  \******************************************************************************/
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("Object.defineProperty(__webpack_exports__, \"__esModule\", { value: true });\nfunction _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError(\"Cannot call a class as a function\"); } }\n\nvar Article = function Article(header, sections) {\n   _classCallCheck(this, Article);\n\n   this.header = header;\n   this.sections = sections;\n};\n\nvar Section = function Section(header, contents) {\n   _classCallCheck(this, Section);\n\n   this.header = header;\n   this.contents = contents;\n};\n\nvar Content = function Content(tag, resource) {\n   _classCallCheck(this, Content);\n\n   this.tag = tag;\n   this.resource = resource;\n};\n\nvar articles = [new Article('～初めての方へ～', [new Section('～気軽に能楽に触れてもらうために～', [new Content('p', '深い歴史を持つ能は世界でも注目を集める伝統芸能です。このサービスは、少しでも能楽の世界に触れる機会を作れればという思いから生まれました。')]), new Section('～多い情報から簡単に見つかる～', [new Content('p', '日本全国75カ所の能舞台で行われる公演の数は非常に多いです。その中から、演目や演者など気になるワードを条件に興味のある公演情報を簡単に探すことができます。')]), new Section('～自分たちで公演を発信していく～', [new Content('p', 'Noh-Event(仮)ではユーザが誰でも公演情報を登録・編集できるようになっています。これをきっかけにユーザ同士が交流できればと考えております。積極的に見つけた能楽の催し・イベントの情報を登録していきましょう。')])])];\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({ articles: articles });//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMzYuanMiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly8vLi9hcHAvamF2YXNjcmlwdC9wYWNrcy92dWUvc3RhdGljX3BhZ2VzL2RhdGFfc3RvcmFnZS9hYm91dF9zZWN0aW9ucy5qcz8xODI3Il0sInNvdXJjZXNDb250ZW50IjpbImZ1bmN0aW9uIF9jbGFzc0NhbGxDaGVjayhpbnN0YW5jZSwgQ29uc3RydWN0b3IpIHsgaWYgKCEoaW5zdGFuY2UgaW5zdGFuY2VvZiBDb25zdHJ1Y3RvcikpIHsgdGhyb3cgbmV3IFR5cGVFcnJvcihcIkNhbm5vdCBjYWxsIGEgY2xhc3MgYXMgYSBmdW5jdGlvblwiKTsgfSB9XG5cbnZhciBBcnRpY2xlID0gZnVuY3Rpb24gQXJ0aWNsZShoZWFkZXIsIHNlY3Rpb25zKSB7XG4gICBfY2xhc3NDYWxsQ2hlY2sodGhpcywgQXJ0aWNsZSk7XG5cbiAgIHRoaXMuaGVhZGVyID0gaGVhZGVyO1xuICAgdGhpcy5zZWN0aW9ucyA9IHNlY3Rpb25zO1xufTtcblxudmFyIFNlY3Rpb24gPSBmdW5jdGlvbiBTZWN0aW9uKGhlYWRlciwgY29udGVudHMpIHtcbiAgIF9jbGFzc0NhbGxDaGVjayh0aGlzLCBTZWN0aW9uKTtcblxuICAgdGhpcy5oZWFkZXIgPSBoZWFkZXI7XG4gICB0aGlzLmNvbnRlbnRzID0gY29udGVudHM7XG59O1xuXG52YXIgQ29udGVudCA9IGZ1bmN0aW9uIENvbnRlbnQodGFnLCByZXNvdXJjZSkge1xuICAgX2NsYXNzQ2FsbENoZWNrKHRoaXMsIENvbnRlbnQpO1xuXG4gICB0aGlzLnRhZyA9IHRhZztcbiAgIHRoaXMucmVzb3VyY2UgPSByZXNvdXJjZTtcbn07XG5cbnZhciBhcnRpY2xlcyA9IFtuZXcgQXJ0aWNsZSgn772e5Yid44KB44Gm44Gu5pa544G4772eJywgW25ldyBTZWN0aW9uKCfvvZ7msJfou73jgavog73mpb3jgavop6bjgozjgabjgoLjgonjgYbjgZ/jgoHjgavvvZ4nLCBbbmV3IENvbnRlbnQoJ3AnLCAn5rex44GE5q205Y+y44KS5oyB44Gk6IO944Gv5LiW55WM44Gn44KC5rOo55uu44KS6ZuG44KB44KL5Lyd57Wx6Iq46IO944Gn44GZ44CC44GT44Gu44K144O844OT44K544Gv44CB5bCR44GX44Gn44KC6IO95qW944Gu5LiW55WM44Gr6Kem44KM44KL5qmf5Lya44KS5L2c44KM44KM44Gw44Go44GE44GG5oCd44GE44GL44KJ55Sf44G+44KM44G+44GX44Gf44CCJyldKSwgbmV3IFNlY3Rpb24oJ++9nuWkmuOBhOaDheWgseOBi+OCieewoeWNmOOBq+imi+OBpOOBi+OCi++9nicsIFtuZXcgQ29udGVudCgncCcsICfml6XmnKzlhajlm703NeOCq+aJgOOBruiDveiInuWPsOOBp+ihjOOCj+OCjOOCi+WFrOa8lOOBruaVsOOBr+mdnuW4uOOBq+WkmuOBhOOBp+OBmeOAguOBneOBruS4reOBi+OCieOAgea8lOebruOChOa8lOiAheOBquOBqeawl+OBq+OBquOCi+ODr+ODvOODieOCkuadoeS7tuOBq+iIiOWRs+OBruOBguOCi+WFrOa8lOaDheWgseOCkuewoeWNmOOBq+aOouOBmeOBk+OBqOOBjOOBp+OBjeOBvuOBmeOAgicpXSksIG5ldyBTZWN0aW9uKCfvvZ7oh6rliIbjgZ/jgaHjgaflhazmvJTjgpLnmbrkv6HjgZfjgabjgYTjgY/vvZ4nLCBbbmV3IENvbnRlbnQoJ3AnLCAnTm9oLUV2ZW50KOS7rinjgafjga/jg6bjg7zjgrbjgYzoqrDjgafjgoLlhazmvJTmg4XloLHjgpLnmbvpjLLjg7vnt6jpm4bjgafjgY3jgovjgojjgYbjgavjgarjgaPjgabjgYTjgb7jgZnjgILjgZPjgozjgpLjgY3jgaPjgYvjgZHjgavjg6bjg7zjgrblkIzlo6vjgYzkuqTmtYHjgafjgY3jgozjgbDjgajogIPjgYjjgabjgYrjgorjgb7jgZnjgILnqY3mpbXnmoTjgavopovjgaTjgZHjgZ/og73mpb3jga7lgqzjgZfjg7vjgqTjg5njg7Pjg4jjga7mg4XloLHjgpLnmbvpjLLjgZfjgabjgYTjgY3jgb7jgZfjgofjgYbjgIInKV0pXSldO1xuXG5leHBvcnQgZGVmYXVsdCB7IGFydGljbGVzOiBhcnRpY2xlcyB9O1xuXG5cbi8vLy8vLy8vLy8vLy8vLy8vL1xuLy8gV0VCUEFDSyBGT09URVJcbi8vIC4vYXBwL2phdmFzY3JpcHQvcGFja3MvdnVlL3N0YXRpY19wYWdlcy9kYXRhX3N0b3JhZ2UvYWJvdXRfc2VjdGlvbnMuanNcbi8vIG1vZHVsZSBpZCA9IDM2XG4vLyBtb2R1bGUgY2h1bmtzID0gMCAxIDkgMzIiXSwibWFwcGluZ3MiOiJBQUFBO0FBQUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSIsInNvdXJjZVJvb3QiOiIifQ==");

/***/ })

/******/ });