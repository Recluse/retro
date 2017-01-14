//----------------------------------------------------------------------------
// Игра "Стань Cтальной Крысой" для компьюетра Апогея БК01Ц
//
// 2014-07-25 Разработано vinxru
//----------------------------------------------------------------------------

// Стандартная ерунда

fso = new ActiveXObject("Scripting.FileSystemObject");
shell = new ActiveXObject("WScript.Shell");
function fileSize(name) { return fso.GetFile(name).Size; }
function loadAll(name) { var f=fso.OpenTextFile(name, 1, false, 0); var r=f.Read(fileSize(name)); f.Close(); return r; } // File.LoadAll глючит 
function save(fileName, data) { var f = fso.CreateTextFile(fileName); f.Write(data); f.close(); }
function exec(cmd) { if(shell.Run(cmd, 2, true)) throw cmd; }
src = loadAll("../tbl.bin"); encode = []; decode = []; for(i=0; i<256; i++) { encode[i] = src.charAt(i); decode[src.charCodeAt(i)] = i; }

function bin2inc(src, dest, x) {
  abc = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' ];
  src = loadAll(src); 
  s = "";
  pos = 0;
  for(i=0;;i++) {
    if((i%x)==0) { if(i!=0) s += " ; "+(pos++)+"\r\n"; }
    if(i>=src.length) break;
    if((i%x)!=0) s += ","; else s += "	.db ";
    v = decode[src.charCodeAt(i)];
    s += '0' + abc[v>>4] + abc[v&0xF] + 'h';
  }
  var f2 = fso.CreateTextFile(dest, true);
  f2.Write(s);
  f2.Close();
}

xlat = [];
xlat['А'] = 'a';
xlat['Б'] = 'b';
xlat['В'] = 'w';
xlat['Г'] = 'g';
xlat['Д'] = 'd';
xlat['Е'] = 'e';
xlat['Ж'] = 'v';
xlat['З'] = 'z';
xlat['И'] = 'i';
xlat['Й'] = 'j';
xlat['К'] = 'k';
xlat['Л'] = 'l';
xlat['М'] = 'm';
xlat['Н'] = 'n';
xlat['О'] = 'o';
xlat['П'] = 'p';
xlat['Р'] = 'r';
xlat['С'] = 's';
xlat['Т'] = 't';
xlat['У'] = 'u';
xlat['Ф'] = 'f';
xlat['Х'] = 'h';
xlat['Ц'] = 'c';
xlat['Ч'] = '~';
xlat['Ш'] = '{';
xlat['Щ'] = '}';
xlat['Ъ'] = 'x';
xlat['Ы'] = 'y';
xlat['Ь'] = 'x';
xlat['Э'] = '|';
xlat['Ю'] = '`';
xlat['Я'] = 'q';

function repl(x) {
  var y = "";
  x = (x+"").toUpperCase();
  for(var i=0; i<x.length; i++) {
    var r = x.charAt(i);
    var c = xlat[r];
    if(c) y += c; else y += r;
  }
  return y;
}

// Расчет контрольной суммы файла

files = [ "a", "b", "c", "d", "e", "f", "h", "i", "i2", "j", "k", "l", "m", "n", "o", "end" ];

exec("cmd /c del *.raw");
exec("cmd /c del *.mlz");
exec("cmd /c del *.inc");

for(ffi in files) {
  ff = files[ffi];

f = fso.OpenTextFile(ff+".txt", 1, false, 0);
//s = "";
ss = "";
//n = 0;
hrefs = [];
line = [];
firstl = true;
while(!f.AtEndOfStream) {
  l =  f.ReadLine();
  if(l.charAt(0)==' ') l=l.substr(1);
  if(l.charAt(0)=='/' && l.charAt(1)=='/') continue;
  ln = (l*1)+0;
  if(ln > 0) {
//    if(s != "") s += "\n";
    if(firstl) firstl=false; else line.push(ss);
    hrefs[ln] = line.length;
    ss = "";
  } else { 
    if(ss!="" && l!="") ss += " ";
//    s += l;
    ss += l;
  }
}
line.push(ss);
f.Close();

/*
pack = "\n! \"(),-.0123456789:;?S[]АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ";
pack1 = [];
for(i=0; i<pack.length; i++)
  pack1[pack.charCodeAt(i)] = i;

/*
ch = [];
for(i=0; i<256; i++)
  ch[ encode[i] ] = 0;  
for(i=0; i<s.length; i++)
  ch[s.charAt(i)] = 1;
h = "";
for(i in ch)
  if(ch[i])
    h += i;
save("words.txt", h);
*/

//save("dest.txt", s);
//save("lines.txt", line);
lock = [];

d = "";
file=1;
//line_file=[];
line_off=[];

//function flush() {
//  var dn = "tmp.txt";
//  var pn = "tmp.mlz";
//  var an = "dest"+(file<10 ? "0" : "")+file+".inc";
//  save(dn, d);
//  file++;
//  d = "";    
//  exec("megalz "+dn+" "+pn);
//  bin2inc(pn, an, 8);
//}

//full = "";

function align(page, startW) {
  if(page.length!=0 && page.charAt(0)==" ") page = page.substr(1);
  if(page.length!=0 && page.charAt(page.length-1)==" ") page = page.substr(0, page.length-1);
  page = page.replace("  "," ").replace("  "," ").replace("  "," ");
  page = page.split(' ');  
  var page2 = "";
  for(var i=0; i<page.length; i++) {
    if(page[i]==0) continue;

    var lineLen = page[i].length;
    var j = i;
    while(j+1 < page.length && lineLen + 1 + page[j+1].length < 60-startW) {
      j++;
      lineLen += 1 + page[j].length;
    }
    
    if(i!=0) page2 += "\n";
    page2 += page[i];
    for(var u=i+1; u<=j; u++) {       
      if(lineLen < 60-startW && j+1<page.length) { lineLen += 1+Math.floor((60-startW-lineLen)/(j-i+1)); page2 += " "; }
      page2 += " " + page[u];
    }

    i = j;
    startW = 0;
  }
  return page2;
}


function go(st, path, deep) {
//  if(lock[st]) return;
//  lock[st]=1;

//  if(path!="") path += "->";
//  path += st;
//  d += "***"+st+" "+path+"***\n";

//  d1 = d + st + "\x00";
//  if(d1.length>4096) flush();

  //full += "*** " + st + " " + path + " ***\n" + line[st] + "\n";
  line_off[st] = d.length;
//  line_file[st] = file;

  var s = (line[st]+"").split("{");
//  if(s.length==1) s = "[9999]".split("[");
//  full += st + "\n" + line[st] + "\n";
//  var jmps = [];
  d += repl(align(s[0], 0)) + "\x00";

  var page2end = "";
  for(var i=1; i<s.length; i++) {
    var s1 = s[i].split("}");
    var href = 0;
    if(s1[0]=="NEXT") {
      href=254;
    } else {
      href = hrefs[s1[0] * 1];
      if(!href) href = 0; //! error
//      if(href==0) href=st; //! error
    }
    d += encode[href];
    d += repl(align(s1[1], 2)) + "\x00";
  }
  d += encode[0xFF];
}

for(var i=0; i<line.length; i++) {
  go(i, "", 0);
}

//save(ff+".ful", full);
save(ff+".raw", d);
exec("megalz "+ff+".raw "+ff+".mlz");
bin2inc(ff+".mlz", ff+".inc", 16);

//  var dn = "tmp.txt";
//  var pn = "tmp.mlz";
//  var an = "dest"+(file<10 ? "0" : "")+file+".inc";
//  save(dn, d);
//  file++;
//  d = "";    


//if(d!="") flush();

/*
un = "";
for(i=1; i<line.length; i++ ){
  if(!lock[i]) {
    un += i + " "  + line[i] + "\n";
  }
}
save("unused.txt", un);

deb = "";
for(i=0; i<line.length; i++) {
//  f = (line_file[i] ? line_file[i] : 0);
  deb += " .dw buffer+" + (line_off[i] ? line_off[i] : "0") + " ; " + i + " \n";
}
save("map.inc", deb);
*/

}

exec("cmd /c del *.raw");
exec("cmd /c del *.mlz");
