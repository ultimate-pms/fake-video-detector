# Fake Video (movie) detector

This script detects any fake videos you may have in your library, based upon an 'index' of screenshots that are taken from a random frame within a fake video.

It uses 'libpuzzle' to visually recognise similar images - this way if the quality or colour slightly varies between movies you download it should (in theory) still catch and match any fake videos.

If any matches are found the script will either log, or totally remove the file **(I suggest you analyse your library, and first review the results before you let it auto-remove files)**.

It is intended to be used in combination with your PVR so you can automatically remove any rubbish content that may have been downloaded.

--------------------------------------------------------

#### Some examples of fake videos:
 - [Xvid codec required to view video](blacklist-originals/183030964134081.jpg)
 - [You're missing CODEC pack to play video (download from some website)](blacklist-originals/222612955025266.jpg)
 - [You need x3player to watch this movie](blacklist-originals/483791103037622.jpg)

![Alt text](screenshot.gif?raw=true)

--------------------------------------------------------

## Prerequisites:
The script straight out of the box, you'll require:

- Docker
- Ffmpeg
- Linux based system

*(I'm planning on moving `ffmpeg` into docker so that it does not manually need to be installed on the host when I have spare time)*

### Running without Docker:

If you must run the script without docker (you may also use the copy of the script in the [no-docker](https://github.com/ultimate-pms/fake-video-detector/tree/no-docker) branch, however it will install ffmpeg, libpizzle, and mogrify on your system).

## Installing:
Run `./setup.sh` to build local docker container, before running `search-nas` or `fake-video`.

## Usage:

The script can be either run as a once-off command by passing a single video file to it (see `./fake-video --help` for all arguments supported), or executed through a third party tool such as your Download Client (qBittorrent etc), or your PVR's "Post Processing" (Radarr, Sonarr, Couchpotato etc).

--------------------------------------------------------

#### `search-nas` (Bulk searching and processing - A good place to start)

This is a simple script that searches a (or multiple) directory and find's all media files (currently set to larger than 30mb) to process through the `fake-video` script. In addition it logs any matched videos to a `fake-movie-paths.txt` file, so you can manually review and remove any matching videos.

You will need to edit the top few lines of the file to match your search  parameters (such as the search location, files, and minimum file size).

#### `fake-video` Supported Arguments:

This is the main script which actually processes the video file. If you are integrating to your PVR or BitTorrent client this is the script you will want to execute. Arguments currently supported as as follows:

```
./fake-video
	-h --help
	--video="<path>" 	 Specify full path to video file in double quotes
	--threshold="0.20" 	 The threshold (between 0 - 1) that a video is matched against - a value of 0 will be blacklisted, and 1 will count as passing. Suggest leaving at default of 0.20
	--build-thumbnails 	 Builds the 'blacklist-resized' directory, this needs to be run if you add or update thumbnails of blacklisted videos
	--silent 		 Suppresses all output - Will return an exit code of '1' for any matching fake videos, and '0' for all other scenarios
	--log 			 Logs result of each video into file (./fake-video.log) - Works well with --silent flag
	--remove 		 If specified, will auto-delete the file

```

## Adding more videos to blacklist:

Simply add a screenshot of a random point in time of your video into the `blacklist-originals` directory and run `./fake-video --build-thumbnails` to rebuild the thumbnails database.

Here's a simple one-liner that will take a screenshot from the start of the video and store it in the `blacklist-originals` directory... (Note you will need to update the *$INPUT_FILE* variable with your file name)

```bash
ffmpeg -i "$INPUT_FILE" -vcodec mjpeg -vframes 1 -an -f rawvideo -ss 100 -preset veryfast "blacklist-originals/$RANDOM$RANDOM$RANDOM.jpg"
```
**BE SURE TO SUBMIT ANY ADDITIONS TO THIS REPO AS A 'PR' OR ADD AS AN ISSUE AND I WILL ADD THEM TO MAKE EVERYONES LIVES BETTER!**