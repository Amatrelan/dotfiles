// ==UserScript==
// @name         WaniKani Katakana For On'yomi
// @author       HaraldN
// @match        https://www.wanikani.com/*
// @match        http://www.wanikani.com/*
// @exclude      https://www.wanikani.com/dashboard
// @exclude      http://www.wanikani.com/dashboard
// @description  A userscript for wanikani that transforms everything related to on'yomi into katakana.
// @version      2.3.1
// @run-at       document-end
// @grant        none
// @license      GPL v3.0
// @namespace https://greasyfork.org/users/856931


// ==/UserScript==
(function() {
	//'use strict';
	console.log("Loading WK Katakana for On'yomi");
	/*
	 * Used for switching between hira and kata (vice versa)
	 */
	var hiraToKata = {"め": "メ", "む": "ム", "ゃ": "ャ", "も": "モ", "ゅ": "ュ", "や": "ヤ", "ょ": "ョ", "ゆ": "ユ", "ら": "ラ", "よ": "ヨ", "る": "ル", "り": "リ", "ろ": "ロ", "れ": "レ", "わ": "ワ", "ん": "ン", "を": "ヲ", "あ": "ア", "い": "イ", "う": "ウ", "え": "エ", "か": "カ", "お": "オ", "き": "キ", "が": "ガ", "く": "ク", "ぎ": "ギ", "け": "ケ", "ぐ": "グ", "こ": "コ", "げ": "ゲ", "さ": "サ", "ご": "ゴ", "し": "シ", "ざ": "ザ", "す": "ス", "じ": "ジ", "せ": "セ", "ず": "ズ", "そ": "ソ", "ぜ": "ゼ", "た": "タ", "ぞ": "ゾ", "ち": "チ", "だ": "ダ", "っ": "ッ", "ぢ": "ヂ", "づ": "ヅ", "つ": "ツ", "で": "デ", "て": "テ", "ど": "ド", "と": "ト", "に": "ニ", "な": "ナ", "ね": "ネ", "ぬ": "ヌ", "は": "ハ", "の": "ノ", "ぱ": "パ", "ば": "バ", "び": "ビ", "ひ": "ヒ", "ふ": "フ", "ぴ": "ピ", "ぷ": "プ", "ぶ": "ブ", "べ": "ベ", "へ": "ヘ", "ほ": "ホ", "ぺ": "ペ", "ぽ": "ポ", "ぼ": "ボ", "み": "ミ", "ま": "マ"};
	var kataToHira = {"メ": "め", "ム": "む", "ャ": "ゃ", "モ": "も", "ュ": "ゅ", "ヤ": "や", "ョ": "ょ", "ユ": "ゆ", "ラ": "ら", "ヨ": "よ", "ル": "る", "リ": "り", "ロ": "ろ", "レ": "れ", "ワ": "わ", "ン": "ん", "ヲ": "を", "ア": "あ", "イ": "い", "ウ": "う", "エ": "え", "カ": "か", "オ": "お", "キ": "き", "ガ": "が", "ク": "く", "ギ": "ぎ", "ケ": "け", "グ": "ぐ", "コ": "こ", "ゲ": "げ", "サ": "さ", "ゴ": "ご", "シ": "し", "ザ": "ざ", "ス": "す", "ジ": "じ", "セ": "せ", "ズ": "ず", "ソ": "そ", "ゼ": "ぜ", "タ": "た", "ゾ": "ぞ", "チ": "ち", "ダ": "だ", "ッ": "っ", "ヂ": "ぢ", "ヅ": "づ", "ツ": "つ", "デ": "で", "テ": "て", "ド": "ど", "ト": "と", "ニ": "に", "ナ": "な", "ネ": "ね", "ヌ": "ぬ", "ハ": "は", "ノ": "の", "パ": "ぱ", "バ": "ば", "ビ": "び", "ヒ": "ひ", "フ": "ふ", "ピ": "ぴ", "プ": "ぷ", "ブ": "ぶ", "ベ": "べ", "ヘ": "へ", "ホ": "ほ", "ペ": "ぺ", "ポ": "ぽ", "ボ": "ぼ", "ミ": "み", "マ": "ま"};

	/* global Stimulus */
	function newPageLoaded(pageLoadEvent) {

		var uri;
		if (pageLoadEvent) {
			uri = pageLoadEvent.target.baseURI;
		} else {
			uri = document.URL;
		}
		console.log('onyomi found new page:' +uri);
		if (/review/.test(uri) || /lesson\/quiz/.test(uri) || /extra_study/.test(uri)) {
			console.log('onyomi quiz page');
			// ***************** QUIZ *****************
			var isCurrentQuestionOnyomi = false;
			var isCurrentQuestionKanji = false;
			var isFirstRun = true;
			var newQuestion = function (e) {
				if (isFirstRun) {
					console.log('onyomi first run on quiz page, inserting data')
					isFirstRun = false;
					// Set up quiz input handler to convert to katakana
					document.getElementById('user-response').addEventListener("input", function(e) {
						if(isCurrentQuestionOnyomi) {
							var element = document.getElementById('user-response');
							if (element.getAttribute("enabled") === "false") {
								return;
							}
							var input = element.value;
							input = input.toUpperCase();
							// must manually convert "N " into correct kana
							if (input.substr(input.length-2, input.length-1) === "N ") {
								input = input.substr(0, input.length-2) + 'ン' + input.substr(input.length);
							}
							input = convertToKata(input);
							element.value = input;
						}
					});
					// Set up submit handler to handle trailing N
					document.getElementById('user-response').addEventListener("keydown", function(e) {
						if(isCurrentQuestionOnyomi && e.key === "Enter") {
							var element = document.getElementById('user-response');
							var input = element.value;
							// convert trailing "N" into correct kana if necessary, and resend event.
							// would be better to somehow catch it sooner to prevent input shake, but I don't know how
							if (input.substr(input.length-1) === "N") {
								input = input.substr(0, input.length-1) + 'ン' + input.substr(input.length);
								element.value = input;
								e.preventDefault();
								e.stopImmediatePropagation();
								element.dispatchEvent (new KeyboardEvent('keydown', {
									code: 'Enter',
									key: 'Enter',
									charCode: 13,
									keyCode: 13,
									view: window,
									bubbles: true
								}));
							}
						}
					});
					let answerChecker = Stimulus.controllers.find(c => c.answerChecker).answerChecker;
					answerChecker.oldEvaluate = answerChecker.evaluate;
					answerChecker.evaluate = function({questionType: qtype, response: answer, item: subject, userSynonyms: synonyms, inputChars: inputs}) {
						if(isCurrentQuestionOnyomi) {
							// this is for trailing N to ン
							if(qtype === "reading" && answer[answer.length-1] === 'N') {
								answer = answer.substr(0, answer.length-1) + 'ン' + answer.substr(answer.length);
							}
							return answerChecker.oldEvaluate({questionType: qtype, response: convertToHira(answer), item: subject, userSynonyms: synonyms, inputChars: inputs});
						}
						return answerChecker.oldEvaluate({questionType: qtype, response: answer, item: subject, userSynonyms: synonyms, inputChars: inputs});
					};
				} // end first run

				if (e.detail.subject.type == 'Kanji') {
					isCurrentQuestionKanji = true;
					if (e.detail.subject.primary_reading_type == "onyomi" && e.detail.questionType == "reading") {
						isCurrentQuestionOnyomi = true;
						console.log("onyomi for current question");
					} else {
						isCurrentQuestionOnyomi = false;
					}
				} else {
					isCurrentQuestionKanji = false;
					isCurrentQuestionOnyomi = false;
				}
			}


			var itemInfoExpand = function (e) {
				if (e.target.id == "subject-info" && isCurrentQuestionKanji) {
					const readings = document.getElementsByClassName("subject-readings")[0].children;
					for (var i=0; i<readings.length; i++) {
						if (readings[i].children[0].innerText == "On’yomi") {
							readings[i].children[1].innerText = convertToKata(readings[i].children[1].innerText);
						}
					}
				}
			}
			window.addEventListener('willShowNextQuestion', newQuestion);
			window.addEventListener('turbo:frame-load', itemInfoExpand);
			//window.addEventListener('didAnswerQuestion', newQuestion);

			// ********* END QUIZ *****************
		}
		else if (/lesson/.test(uri)) {
			console.log('onyomi lesson page');
			var replaceInItemInfo = function (readingDiv) {
				if (readingDiv) {
					var parentElement =readingDiv.children[1].children[0].children[0];
					if (parentElement.children[0].innerText.includes("on’yomi")) {
						//replace sidebar
						//parentElement.children[1].innerHTML=convertToKata(parentElement.children[1].innerHTML)
						readingDiv.innerHTML=convertToKata(readingDiv.innerHTML)
					}
				}
			}
			if (pageLoadEvent) {
				replaceInItemInfo(pageLoadEvent.detail.newBody.querySelector("#reading"))
			} else {
				replaceInItemInfo(document.getElementById("reading"));
			}
		}
	} // main function end

	document.addEventListener('turbo:before-render', newPageLoaded);
	//-- Helper functions for transforming kata <-> hira --//

	function convertToKata(chain)
	{
		//chain = chain.trim();
		for (var i = 0, c = chain.length; i < c; i++)
		{
			chain = replaceAt(chain, i, hiraToKata[chain[i]] || chain[i]);
		}
		return chain;
	}

	function convertToHira(chain)
	{
		//chain = chain.trim();
		for (var i = 0, c = chain.length; i < c; i++)
		{
			chain = replaceAt(chain, i, kataToHira[chain[i]] || chain[i]);
		}
		return chain;
	}

	function replaceAt(s, n, t)
	{
		return s.substring(0, n) + t + s.substring(n + 1);
	}

	function observeDOM() {
		var MutationObserver = window.MutationObserver || window.WebKitMutationObserver,
			eventListenerSupported = window.addEventListener;
		return function(obj, callback){
			if( MutationObserver ) {
				// define a new observer
				var obs = new MutationObserver(function(mutations, observer) {
					if( mutations[0].addedNodes.length ) {
						callback();
					}
				});
				// have the observer observe foo for changes in children
				if (obj) {
					obs.observe( obj, {childList:true, subtree:true, attributes:false });
				} else {
					console.trace('Unable to observe changes in DOM for katakana madness');
				}
			}
			else if( eventListenerSupported ) {
				obj.addEventListener('DOMNodeInserted', callback, false);
				obj.addEventListener('DOMNodeRemoved', callback, false);
			}
		};
	}

	function observeDOMForAttributes() {
		var MutationObserver = window.MutationObserver || window.WebKitMutationObserver,
			eventListenerSupported = window.addEventListener;
		return function(obj, callback){
			if( MutationObserver ) {
				// define a new observer
				var obs = new MutationObserver(function(mutations, observer) {
					callback();
				});
				// have the observer observe foo for changes in children
				if (obj) {
					obs.observe( obj, {childList:true, subtree:true, attributes:true });
				} else {
					console.trace('Unable to observe changes in DOM for katakana madness');
				}
			}
			else if( eventListenerSupported ) {
				obj.addEventListener('DOMNodeInserted', callback, false);
				obj.addEventListener('DOMNodeRemoved', callback, false);
			}
		};
	}
	newPageLoaded();
})();

