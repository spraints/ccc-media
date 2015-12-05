# Auto-sync sermon notes to the website

Ideally, this will work like this:

1. Get a callback from Dropbox when new files are added.
2. ~~When there's a new `bulletin*` file, upload it to the clover site.~~ All Dropbox files have a sharable URL.
3. Update a thing on the clover site to point to the new file.

Here's the directory where the bulletin would show up:

    $ ls ~/Dropbox/Misc/Tim\'s\ Sermon\ Materials/
    Blessed to Be a Blessing 112215 16x9 .pptx      bulletin 092015 pdf.pdf
    Blessed to Be a Blessing 112215 4x3 ppt.pptx    bulletin 111515 pdf.pdf
    Blessed to Share Christ 112915 16x9 ppt.pptx    bulletin 112215 pdf.pdf
    Blessed to Share Christ 112915 4x3 ppt.pptx     bulletin 112915 pdf.pdf

Since Clover doesn't have an API, and since Dropbox can hit webhooks, I think I'll set up a web app with these endpoints:

* admin, for setting up the Dropbox integration
* dropbox webhook, for receiving information about new files
* landing pages from clover
  * current bulletin
  * old bulletins
  * current sermon
  * old sermons

If I do the sermon stuff, there will need to be a thing that parses clover's list of sermons.
