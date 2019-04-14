# Fake Video (movie) detector

This script detects any fake videos you may have in your library, based upon an 'index' of screenshots that are taken from a random frame within a fake video.

It uses 'libpuzzle' to visually recognise similar images - this way if the quality or colour slightly varies between movies you download it should (in theory) still catch and match any fake videos.

If any matches are found the script will either log, or totally remove the file **(I suggest you analyse your library, and first review the results before you configure it to auto-remove files)**.

It is intended to be used in combination with your PVR so you can automatically remove any rubbish content that may have been downloaded.

--------------------------------------------------------

**Docker Hub:** [`ultimatepms/fake-video-detector `](https://hub.docker.com/r/ultimatepms/fake-video-detector)

![Docker Pulls](https://img.shields.io/docker/pulls/ultimatepms/fake-video-detector.png)


#### Some examples of fake videos:
 - [Xvid codec required to view video](blacklist-originals/183030964134081.jpg)
 - [You're missing CODEC pack to play video (download from some website)](blacklist-originals/222612955025266.jpg)
 - [You need x3player to watch this movie](blacklist-originals/483791103037622.jpg)

![Alt text](screenshot.gif?raw=true)

--------------------------------------------------------

## Prerequisites:
The script straight out of the box, you'll require:

- Docker

### Running without Docker:

If you _must_ run the script without docker, you may use the copy of the script in the [no-docker](https://github.com/ultimate-pms/fake-video-detector/tree/no-docker) branch, however ffmpeg, libpizzle, and mogrify MUST be installed on your system - **The non docker branch is no-longer maintained as of April 2019.**

## Installing:
Run `./setup.sh` to install the 'fake-video' command into your local bash/zsh environment... If you are ONLY going to execute this from another process (i.e. Radarr or Sonarr) you may skip this step.

## Running:

The script can be either run as a once-off command by passing a single video file to it _(see all arguments supported below)_, or executed through a third party tool such as your Download Client (qBittorrent etc), or your PVR's "Post Processing" (Radarr, Sonarr, Couchpotato etc).

### Running directly, with a single file

```bash
docker run -it --rm \
  -v "/path/to/movies:/path/to/movies" \
  ultimatepms/fake-video-detector:latest \
  fake-video --video="/path/to/movies/example.mp4"
```

### Bulk Searching all your media files

This is a simple script that searches your directories & find's all video files (set to larger than 30mb) to process through the `fake-video` script. In addition it logs any matched videos to a `fake-movie-paths.txt` file, so you can manually review and remove any matching videos.

```bash
docker run -it --rm \
  -v "/path/to/movies:/path/to/movies" \
  ultimatepms/fake-video-detector:latest \
  bulk-search --search-location="/path/to/movies"
```
Note that files will not be auto-deleted with bulk-search unless you specify the flag `--remove` after the search-location parameter. 


## More advanced, supported arguments: 
### `fake-video`:

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

### `bulk-search`:

```
./bulk-search
	-h --help
	--search-location="<path>" 	 Specify the directory you would like to search - Wildcards are accepted i.e. '/nas/*/Movies'
	--remove 			 If specified, will delete any files matched (DOES NOT RUN BY DEFAULT)
```

## Contributing

**IF YOU HAVE ANY ADDITIONAL FAKE VIDEO SCREENSHOTS, PLEASE ADD THEM INTO THE REPO AND SUBMIT A PR! - YOU MAY ALSO LOG AS AN ISSUE AND I WILL MANUALLY ADD THEM IN IF YOU'RE LAZY...**

### Adding more videos to blacklist:

Simply add a screenshot of a random point in time of your video into the `blacklist-originals` directory and run `./fake-video --build-thumbnails` to rebuild the thumbnails database.

Here's a simple one-liner that will take a screenshot from the start of the video and store it in the `blacklist-originals` directory... (Note you will need to update the *$INPUT_FILE* variable with your file name)

```bash
ffmpeg -i "$INPUT_FILE" -vcodec mjpeg -vframes 1 -an -f rawvideo -ss 100 -preset veryfast "blacklist-originals/$RANDOM$RANDOM$RANDOM.jpg"
```

