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
/******/ 	__webpack_require__.p = "/packs-test/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 52);
/******/ })
/************************************************************************/
/******/ ({

/***/ 52:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Article = function Article(header, sections) {
   _classCallCheck(this, Article);

   this.header = header;
   this.sections = sections;
};

var Section = function Section(header, contents) {
   _classCallCheck(this, Section);

   this.header = header;
   this.contents = contents;
};

var Content = function Content(tag, resource) {
   _classCallCheck(this, Content);

   this.tag = tag;
   this.resource = resource;
};

var articles = [new Article('～初めての方へ～', [new Section('～気軽に能楽に触れてもらうために～', [new Content('p', '深い歴史を持つ能は世界でも注目を集める伝統芸能です。このサービスは、少しでも能楽の世界に触れる機会を作れればという思いから生まれました。')]), new Section('～多い情報から簡単に見つかる～', [new Content('p', '日本全国75カ所の能舞台で行われる公演の数は非常に多いです。その中から、演目や演者など気になるワードを条件に興味のある公演情報を簡単に探すことができます。')]), new Section('～自分たちで公演を発信していく～', [new Content('p', 'Noh-Event(仮)ではユーザが誰でも公演情報を登録・編集できるようになっています。これをきっかけにユーザ同士が交流できればと考えております。積極的に見つけた能楽の催し・イベントの情報を登録していきましょう。')])])];

/* harmony default export */ __webpack_exports__["default"] = ({ articles: articles });

/***/ })

/******/ });