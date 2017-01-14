// (c) 2012 vinxru

int APIENTRY _tWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR    lpCmdLine, int       nCmdShow) {
  vector<char> data;
  loadFile(data, "input.mod");

  FillBuffer buf;

  vector<int> notes;
  notes.push_back(0);
  notes.push_back(10);

  int channel[3];
  channel[0] = -1;
  channel[1] = -1;
  channel[2] = -1;

  for(int i=0; i<128; i++) {
    int ii = data[0x3B8+i];
    if(ii==0 && i!=0) 
      break;
    char* p = data.begin() + 0x43C + ii*1024;// + (ii/16);
    for(int n=0; n<64; n++) {
      for(int c=0; c<3; c++) {
        int inst = (p[2]>>4)&0xF;
        int hz;
        if(inst==8) {
          hz=10;
        } else {
          hz = ((int)(unsigned char)p[1]) + (((int)(unsigned char)p[0])&0xF)*256;
          hz <<= 4;
        //  if(hz!=0) hz += c*4;
        }
        // pause
        if(hz==0) {          
          if(channel[c]!=-1 && ((unsigned char)buf.buf[channel[c]]) < 0xE0) {
            buf.buf[channel[c]] += 0x20;
          } else {
            channel[c]=buf.buf.size();
            buf.str("\x00", 1); 
          }
        } else {
          // note
          int p = notes.findi(hz);
          if(p==-1) { notes.push_back(hz); p=notes.size()-1; }
          channel[c] = buf.buf.size();
          buf.str((char*)&p, 1);          
        }
        p+=4;
      }
      // Пропускаем 4-ый канал
      p+=4;
    }
  }

  buf.str("\xFF");

  FillBuffer notes1;
  notes1.str("  dw ");
  for(int i=0; i<notes.size(); i++) {
    if(i>0) notes1.str(",");
    notes1.i2s(notes[i]);
  }
  saveFile("music_notes.inc", fcmCreateAlways, notes1.buf);

  saveFile("music.bin", fcmCreateAlways, buf.buf);

	return 0;
}
