#help_index "Within/Journal"

public U8 *Today() {
  CDateStruct now;
  Date2Struct(&now, Now());
  U8 *buf = CAlloc(16);
  StrPrint(buf, "%d-%d-%d.DD", now.year, now.mon, now.day_of_mon);
  return buf;
}

public U0 Journal(U8 *path="D:/Journal") {
  static U8 fname[STR_LEN];
  StrPrint(fname, "%s/%s", path, Today());
  "Editing %s...\n", fname;
  Ed(fname);
  Free(fname);
}

public U0 Divination() {
  Journal("D:/Divination");
}

public U0 SendToday(U8 *path="D:/Journal") {
  static U8 fname[STR_LEN];
  StrPrint(fname, "%s/%s", path, Today());
  SendFile(fname);
}

//Journal;
//SendToday;

