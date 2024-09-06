Prepare content:

  $ cd $CRAMTMP
  $ mkdir stagedir
  $ echo "content-a" >> stagedir/a
  $ echo "content-b" >> stagedir/b

Create reference DMGs using macOS:

  $ mkdir reference
  $ hdiutil create -megabytes 5 -fs HFS+ -volname myDisk -srcfolder stagedir reference/hdiutil.hfs
  created: */reference/hdiutil.hfs.dmg (glob)
  $ xattr -w 'attr-key-a' '__MOZILLA__attr-value-a' stagedir/a
  $ hdiutil create -megabytes 5 -fs HFS+ -volname myDisk -srcfolder stagedir reference/hdiutila.hfs
  created: */reference/hdiutila.hfs.dmg (glob)
  $ xattr -w 'attr-key-b' '__MOZILLA__attr-value-b' stagedir/b
  $ hdiutil create -megabytes 5 -fs HFS+ -volname myDisk -srcfolder stagedir reference/hdiutilab.hfs
  created: */reference/hdiutilab.hfs.dmg (glob)
  $ xattr -c stagedir/a
  $ hdiutil create -megabytes 5 -fs HFS+ -volname myDisk -srcfolder stagedir reference/hdiutilb.hfs
  created: */reference/hdiutilb.hfs.dmg (glob)
