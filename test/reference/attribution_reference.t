This takes about 10 seconds, which is too slow for constant inputs.
Run this like
```
time venv/bin/cram test/attribution.t --keep-tmpdir
```
and then copy the reference directory like
```
cp -R /var/folders/3s/_m9prk6n7g5cx6hhs_33q2f80000gn/T/cramtests-0uzbp0wu/reference test/reference
```
to update test inputs.

Make sure we have a fresh build:

  $ export BUILDDIR=$TESTDIR/../build
  $ cd $BUILDDIR
  $ make &> /dev/null
  $ cd $CRAMTMP

Prepare content:

  $ mkdir stagedir
  $ echo "content-x" >> stagedir/x

Create reference DMGs using macOS:

  $ mkdir reference
  $ xattr -w 'attr-key' '__MOZILLA__attr-value-a' stagedir/x
  $ hdiutil create -megabytes 5 -fs HFS+ -volname myDisk -srcfolder stagedir reference/hdiutila.hfs
  created: */reference/hdiutila.hfs.dmg (glob)
  $ xattr -w 'attr-key' '__MOZILLA__attr-value-b' stagedir/x
  $ hdiutil create -megabytes 5 -fs HFS+ -volname myDisk -srcfolder stagedir reference/hdiutilb.hfs
  created: */reference/hdiutilb.hfs.dmg (glob)
  $ xattr -w 'attr-key' '__MOZILLA__attr-value-p' stagedir/x
  $ hdiutil create -megabytes 5 -fs HFS+ -volname myDisk -srcfolder stagedir reference/hdiutilp.hfs
  created: */reference/hdiutilp.hfs.dmg (glob)

Extract reference HFSs:

  $ $BUILDDIR/dmg/dmg extract reference/hdiutila.hfs.dmg reference/hdiutila.hfs > /dev/null
  $ $BUILDDIR/dmg/dmg extract reference/hdiutilb.hfs.dmg reference/hdiutilb.hfs > /dev/null
  $ $BUILDDIR/dmg/dmg extract reference/hdiutilp.hfs.dmg reference/hdiutilp.hfs > /dev/null

Remove the unneeded dmg:

  $ rm reference/hdiutilp.hfs.dmg
