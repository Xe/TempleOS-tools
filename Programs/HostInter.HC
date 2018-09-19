#include "~/Comm.HC.Z"

#help_index "Within/HostInter"

public U0 SendFile(U8 *fname) {
  CFile *fout = FOpen(fname, "r");
  I64 size = FSize(fout);
  FClose(fout);
  "Sending %s:%d:", fname, size;
  CommPrint(1, "SENDFILE %s %d\n", fname, size);
  U8 *buf;
  buf = FileRead(fname);
  if (buf == NULL) {
    "$FG,13$can't read from file$FG$\n";
  }  
  CommPutS(1, buf);
  CommPutS(1, "\n\n");
  Free(buf);
}
