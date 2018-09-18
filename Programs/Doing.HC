// A parody of IRC bot spam on Freenode. The bots would come in out of nowhere
// and then start flooding "%s is not doing, allah is doing" over and over.
//
// I am specifically doing this with a word that `god` the RNG picks because
// of the histroy involving Christianity and Islam. They have the same god.
// It's officially not blasphemy!

U0 Doing(U8 *who="allah") {
  "%s is not doing, %s is doing", GodWordStr(), who;
}
