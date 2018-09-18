U0 Journal(U8 *path="D:/Journal") {
  CDateStruct now;
  static U8 fname[STR_LEN];
  Date2Struct(&now, Now());
  StrPrint(fname, "%s/%d-%d-%d.DD.Z", path, now.year, now.mon, now.day_of_mon);
  "Editing %s...\n", fname;
  Ed(fname);
}

//Journal;
