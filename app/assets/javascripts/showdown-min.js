var Showdown={};Showdown.converter=function(){var a;var j;var B;var i=0;this.makeHtml=function(I){a=new Array();
j=new Array();B=new Array();I=I.replace(/~/g,"~T");I=I.replace(/\$/g,"~D");I=I.replace(/\r\n/g,"\n");
I=I.replace(/\r/g,"\n");I="\n\n"+I+"\n\n";I=z(I);I=I.replace(/^[ \t]+$/mg,"");I=m(I);
I=d(I);I=H(I);I=q(I);I=I.replace(/~D/g,"$$");I=I.replace(/~T/g,"~");return I};var d=function(I){var I=I.replace(/^[ ]{0,3}\[(.+)\]:[ \t]*\n?[ \t]*<?(\S+?)>?[ \t]*\n?[ \t]*(?:(\n*)["(](.+?)[")][ \t]*)?(?:\n+|\Z)/gm,function(L,N,M,K,J){N=N.toLowerCase();
a[N]=h(M);if(K){return K+J}else{if(J){j[N]=J.replace(/"/g,"&quot;")}}return""});return I
};var m=function(K){K=K.replace(/\n/g,"\n\n");var J="p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math|ins|del";
var I="p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math";
K=K.replace(/^(<(p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math|ins|del)\b[^\r]*?\n<\/\2>[ \t]*(?=\n+))/gm,x);
K=K.replace(/^(<(p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math)\b[^\r]*?.*<\/\2>[ \t]*(?=\n+)\n)/gm,x);
K=K.replace(/(\n[ ]{0,3}(<(hr)\b([^<>])*?\/?>)[ \t]*(?=\n{2,}))/g,x);K=K.replace(/(\n\n[ ]{0,3}<!(--[^\r]*?--\s*)+>[ \t]*(?=\n{2,}))/g,x);
K=K.replace(/(?:\n\n)([ ]{0,3}(?:<([?%])[^\r]*?\2>)[ \t]*(?=\n{2,}))/g,x);K=K.replace(/\n\n/g,"\n");
return K};var x=function(I,J){var K=J;K=K.replace(/\n\n/g,"\n");K=K.replace(/^\n/,"");
K=K.replace(/\n+$/g,"");K="\n\n~K"+(B.push(K)-1)+"K\n\n";return K};var H=function(J){J=A(J);
J=m(J);J=f(J);var I=o("<hr />");J=J.replace(/^[ ]{0,2}([ ]?\*[ ]?){3,}[ \t]*$/gm,I);
J=J.replace(/^[ ]{0,2}([ ]?\-[ ]?){3,}[ \t]*$/gm,I);J=J.replace(/^[ ]{0,2}([ ]?\_[ ]?){3,}[ \t]*$/gm,I);
J=F(J);J=b(J);J=u(J);J=m(J);J=g(J);return J};var r=function(I){I=D(I);I=l(I);I=e(I);
I=G(I);I=y(I);I=n(I);I=h(I);I=c(I);I=I.replace(/  +\n/g," <br />\n");return I};var l=function(J){var I=/(<[a-z\/!$]("[^"]*"|'[^']*'|[^'">])*>|<!(--.*?--\s*)+>)/gi;
J=J.replace(I,function(L){var K=L.replace(/(.)<\/?code>(?=.)/g,"$1`");K=w(K,"\\`*_");
return K});return J};var y=function(I){I=I.replace(/(\[((?:\[[^\]]*\]|[^\[\]])*)\][ ]?(?:\n[ ]*)?\[(.*?)\])()()()()/g,E);
I=I.replace(/(\[((?:\[[^\]]*\]|[^\[\]])*)\]\([ \t]*()<?(.*?)>?[ \t]*((['"])(.*?)\6[ \t]*)?\))/g,E);
I=I.replace(/(\[([^\[\]]+)\])()()()()()/g,E);return I};var E=function(O,U,T,S,R,Q,N,M){if(M==undefined){M=""
}var L=U;var J=T;var K=S.toLowerCase();var I=R;var P=M;if(I==""){if(K==""){K=J.toLowerCase().replace(/ ?\n/g," ")
}I="#"+K;if(a[K]!=undefined){I=a[K];if(j[K]!=undefined){P=j[K]}}else{if(L.search(/\(\s*\)$/m)>-1){I=""
}else{return L}}}I=w(I,"*_");var V='<a href="'+I+'"';if(P!=""){P=P.replace(/"/g,"&quot;");
P=w(P,"*_");V+=' title="'+P+'"'}V+=">"+J+"</a>";return V};var G=function(I){I=I.replace(/(!\[(.*?)\][ ]?(?:\n[ ]*)?\[(.*?)\])()()()()/g,t);
I=I.replace(/(!\[(.*?)\]\s?\([ \t]*()<?(\S+?)>?[ \t]*((['"])(.*?)\6[ \t]*)?\))/g,t);
return I};var t=function(O,U,T,S,R,Q,N,M){var L=U;var K=T;var J=S.toLowerCase();var I=R;
var P=M;if(!P){P=""}if(I==""){if(J==""){J=K.toLowerCase().replace(/ ?\n/g," ")}I="#"+J;
if(a[J]!=undefined){I=a[J];if(j[J]!=undefined){P=j[J]}}else{return L}}K=K.replace(/"/g,"&quot;");
I=w(I,"*_");var V='<img src="'+I+'" alt="'+K+'"';P=P.replace(/"/g,"&quot;");P=w(P,"*_");
V+=' title="'+P+'"';V+=" />";return V};var f=function(I){I=I.replace(/^(.+)[ \t]*\n=+[ \t]*\n+/gm,function(J,K){return o("<h1>"+r(K)+"</h1>")
});I=I.replace(/^(.+)[ \t]*\n-+[ \t]*\n+/gm,function(K,J){return o("<h2>"+r(J)+"</h2>")
});I=I.replace(/^(\#{1,6})[ \t]*(.+?)[ \t]*\#*\n+/gm,function(J,M,L){var K=M.length;
return o("<h"+K+">"+r(L)+"</h"+K+">")});return I};var p;var F=function(J){J+="~0";
var I=/^(([ ]{0,3}([*+-]|\d+[.])[ \t]+)[^\r]+?(~0|\n{2,}(?=\S)(?![ \t]*(?:[*+-]|\d+[.])[ \t]+)))/gm;
if(i){J=J.replace(I,function(L,O,N){var P=O;var M=(N.search(/[*+-]/g)>-1)?"ul":"ol";
P=P.replace(/\n{2,}/g,"\n\n\n");var K=p(P);K=K.replace(/\s+$/,"");K="<"+M+">"+K+"</"+M+">\n";
return K})}else{I=/(\n\n|^\n?)(([ ]{0,3}([*+-]|\d+[.])[ \t]+)[^\r]+?(~0|\n{2,}(?=\S)(?![ \t]*(?:[*+-]|\d+[.])[ \t]+)))/g;
J=J.replace(I,function(M,Q,O,L){var P=Q;var R=O;var N=(L.search(/[*+-]/g)>-1)?"ul":"ol";
var R=R.replace(/\n{2,}/g,"\n\n\n");var K=p(R);K=P+"<"+N+">\n"+K+"</"+N+">\n";return K
})}J=J.replace(/~0/,"");return J};p=function(I){i++;I=I.replace(/\n{2,}$/,"\n");I+="~0";
I=I.replace(/(\n)?(^[ \t]*)([*+-]|\d+[.])[ \t]+([^\r]+?(\n{1,2}))(?=\n*(~0|\2([*+-]|\d+[.])[ \t]+))/gm,function(L,N,M,K,J){var P=J;
var O=N;var Q=M;if(O||(P.search(/\n{2,}/)>-1)){P=H(s(P))}else{P=F(s(P));P=P.replace(/\n$/,"");
P=r(P)}return"<li>"+P+"</li>\n"});I=I.replace(/~0/g,"");i--;return I};var b=function(I){I+="~0";
I=I.replace(/(?:\n\n|^)((?:(?:[ ]{4}|\t).*\n+)+)(\n*[ ]{0,3}[^ \t\n]|(?=~0))/g,function(J,L,K){var M=L;
var N=K;M=v(s(M));M=z(M);M=M.replace(/^\n+/g,"");M=M.replace(/\n+$/g,"");M="<pre><code>"+M+"\n</code></pre>";
return o(M)+N});I=I.replace(/~0/,"");return I};var o=function(I){I=I.replace(/(^\n+|\n+$)/g,"");
return"\n\n~K"+(B.push(I)-1)+"K\n\n"};var A=function(I){I=I.replace(/(^|[^\\])(```+)([ \t]*\w+\s*\n|\s*\n)([^\2]+?)\2(?!`)/gm,function(L,N,M,K,J,Q){var O=K.trim();
var P=J;P=v(P);P=z(P);P=P.replace(/^\n+/g,"");P=P.replace(/\n+$/g,"");return N+'<pre><code class="'+O+'">'+P+"</code></pre>"
});return I};var D=function(I){I=I.replace(/(^|[^\\])(`+)([^\r]*?[^`])\2(?!`)/gm,function(L,N,M,K,J){var O=K;
O=O.replace(/^([ \t]*)/g,"");O=O.replace(/[ \t]*$/g,"");O=v(O);return N+"<code>"+O+"</code>"
});return I};var v=function(I){I=I.replace(/&/g,"&amp;");I=I.replace(/</g,"&lt;");
I=I.replace(/>/g,"&gt;");I=w(I,"*_{}[]\\",false);return I};var c=function(I){I=I.replace(/(\*\*|__)(?=\S)([^\r]*?\S[*_]*)\1/g,"<strong>$2</strong>");
I=I.replace(/(\*|_)(?=\S)([^\r]*?\S)\1/g,"<em>$2</em>");return I};var u=function(I){I=I.replace(/((^[ \t]*>[ \t]?.+\n(.+\n)*\n*)+)/gm,function(J,K){var L=K;
L=L.replace(/^[ \t]*>[ \t]?/gm,"~0");L=L.replace(/~0/g,"");L=L.replace(/^[ \t]+$/gm,"");
L=H(L);L=L.replace(/(^|\n)/g,"$1  ");L=L.replace(/(\s*<pre>[^\r]+?<\/pre>)/gm,function(M,N){var O=N;
O=O.replace(/^  /mg,"~0");O=O.replace(/~0/g,"");return O});return o("<blockquote>\n"+L+"\n</blockquote>")
});return I};var g=function(O){O=O.replace(/^\n+/g,"");O=O.replace(/\n+$/g,"");var N=O.split(/\n{2,}/g);
var K=new Array();var I=N.length;for(var J=0;J<I;J++){var M=N[J];if(M.search(/~K(\d+)K/g)>=0){K.push(M)
}else{if(M.search(/\S/)>=0){M=r(M);M=M.replace(/^([ \t]*)/g,"<p>");M+="</p>";K.push(M)
}}}I=K.length;for(var J=0;J<I;J++){while(K[J].search(/~K(\d+)K/)>=0){var L=B[RegExp.$1];
L=L.replace(/\$/g,"$$$$");K[J]=K[J].replace(/~K\d+K/,L)}}return K.join("\n\n")};var h=function(I){I=I.replace(/&(?!#?[xX]?(?:[0-9a-fA-F]+|\w+);)/g,"&amp;");
I=I.replace(/<(?![a-z\/?\$!])/gi,"&lt;");return I};var e=function(I){I=I.replace(/\\(\\)/g,k);
I=I.replace(/\\([`*_{}\[\]()>#+-.!])/g,k);return I};var n=function(I){I=I.replace(/<((https?|ftp|dict):[^'">\s]+)>/gi,'<a href="$1">$1</a>');
I=I.replace(/<(?:mailto:)?([-.\w]+\@[-a-z0-9]+(\.[-a-z0-9]+)*\.[a-z]+)>/gi,function(J,K){return C(q(K))
});return I};var C=function(K){function J(M){var L="0123456789ABCDEF";var N=M.charCodeAt(0);
return(L.charAt(N>>4)+L.charAt(N&15))}var I=[function(L){return"&#"+L.charCodeAt(0)+";"
},function(L){return"&#x"+J(L)+";"},function(L){return L}];K="mailto:"+K;K=K.replace(/./g,function(L){if(L=="@"){L=I[Math.floor(Math.random()*2)](L)
}else{if(L!=":"){var M=Math.random();L=(M>0.9?I[2](L):M>0.45?I[1](L):I[0](L))}}return L
});K='<a href="'+K+'">'+K+"</a>";K=K.replace(/">.+:/g,'">');return K};var q=function(I){I=I.replace(/~E(\d+)E/g,function(J,L){var K=parseInt(L);
return String.fromCharCode(K)});return I};var s=function(I){I=I.replace(/^(\t|[ ]{1,4})/gm,"~0");
I=I.replace(/~0/g,"");return I};var z=function(I){I=I.replace(/\t(?=\t)/g,"    ");
I=I.replace(/\t/g,"~A~B");I=I.replace(/~B(.+?)~A/g,function(J,M,L){var O=M;var K=4-O.length%4;
for(var N=0;N<K;N++){O+=" "}return O});I=I.replace(/~A/g,"    ");I=I.replace(/~B/g,"");
return I};var w=function(M,J,K){var I="(["+J.replace(/([\[\]\\])/g,"\\$1")+"])";if(K){I="\\\\"+I
}var L=new RegExp(I,"g");M=M.replace(L,k);return M};var k=function(I,K){var J=K.charCodeAt(0);
return"~E"+J+"E"}};