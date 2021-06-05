# Archived

To start this back up again:

1. Deploy this to heroku, set up a custom domain (e.g. db.frankfortccc.com), and set it up with a plan that allows https.
1. Ensure `DROPBOX_KEY` and `DROPBOX_SECRET` are correct in `heroku config`. Create or modify an app in the [Dropbox app console](https://www.dropbox.com/developers/apps).
1. Log in to https://db.frankfortccc.com/admin and ensure sync is enabled for the right account. If you haven't logged into the app before, you might need to create a record in the `dropbox_users` table first.
1. I don't remember how to set up webhooks. There might be a step here you need to complete.
1. Paste a snippet like the one below into a webpage:

```html
<p>You can view the <a href="http://db.frankfortccc.com/bulletins/current">sermon notes</a> for the current sermon here.</p>
```

# CCC-Media

This app ran https://db.frankfortccc.com/. It watches a shared folder in Dropbox for new files that are named a certain way. All matched files are served from this app with a permalink. This app doesn't archive the files, though, so if they get removed from Dropbox they become unavailable. The most recent file is available at `/bulletins/current`. This is a low-friction way for church staff to update the current bulletin on the church website.
