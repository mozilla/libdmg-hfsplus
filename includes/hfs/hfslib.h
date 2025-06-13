#include "common.h"
#include "hfsplus.h"
#include "abstractfile.h"

/* Strategies for handling input files that are symlinks. */
typedef enum {
	/* Traverse symlinks encountered in the input. If a symlink points to a
	   directory, recurse into that directory as though it were a subdirectory;
	  if a symlink points to a file, treat that file as though it were literally
		 in the locaiton of the symlink. */
	kIncomingSymlinksTraverse,

	/* Copy symlinks encountered in the input, creating symlinks in the resulting
	   HFS+ volume. The item referred to by the symlink (in its original location)
	   is not considered and does not need to exist. */
	kIncomingSymlinksCopy,

	/* No symlinks should be in the input. If any are present, crash. */
	kIncomingSymlinksFail
} IncomingSymlinkPolicy;

#ifdef __cplusplus
extern "C" {
#endif
	void writeToFile(HFSPlusCatalogFile* file, AbstractFile* output, Volume* volume);
	void writeToHFSFile(HFSPlusCatalogFile* file, AbstractFile* input, Volume* volume);
	void get_hfs(Volume* volume, const char* inFileName, AbstractFile* output);
	int add_hfs(Volume* volume, AbstractFile* inFile, const char* outFileName);
	void grow_hfs(Volume* volume, uint64_t newSize);
	void removeAllInFolder(HFSCatalogNodeID folderID, Volume* volume, const char* parentName);
	/* Copies all files in the current working directory into the directory named
		`parentName` under the HFS folder with ID `folderID` in volume `volume`.
		Crashes on failure. Symlinks in the input are traversed. On name
		conflict, overwrite. Certain paths with fixed names receive special
		permissions. parentName must end with a forward slash (path separator) unless it is
		the empty string. */
	void addAllInFolder(HFSCatalogNodeID folderID, Volume* volume, const char* parentName);
	/* Like `addAllInFolder`, except the `symlinkPolicy` parameter controls how
	   symlinks in the input are handled, and `assignSpecialPermissions` controls
		 whether to assign alternate permissions to specified paths, used for
		 system images, installation packages, and BootNeuter. */
	void addAllInFolder2(
			HFSCatalogNodeID folderID, Volume* volume, const char* parentName,
			IncomingSymlinkPolicy symlinkPolicy, char assignSpecialPermissions);
	void addall_hfs(Volume* volume, const char* dirToMerge, const char* dest);
	void extractAllInFolder(HFSCatalogNodeID folderID, Volume* volume);
	int copyAcrossVolumes(Volume* volume1, Volume* volume2, char* path1, char* path2);

	void hfs_untar(Volume* volume, AbstractFile* tarFile);
	void hfs_ls(Volume* volume, const char* path);
	void hfs_setsilence(int s);
#ifdef __cplusplus
}
#endif

