# fxb
Fluxbook (fxb) is a linux command line utility to quickly take vim notes and have them synced to a webhook for processing. 

## Instructions:

- Save the script: Save the script above into a file named fxb.
- Make it executable: Run chmod +x fxb to make the script executable.
- Move to a directory in your PATH: Move the script to /usr/local/bin/ or any directory that's in your PATH environment variable:

```sudo mv fxb /usr/local/bin/```

- Edit the .env file: The first time you run the script, it will create the .env file and prompt you to edit it. Add your webhook URL in the following format:

```WEBHOOK_URL='https://yourwebhook.url/endpoint'```

- Run the script: Simply type fxb in your terminal and press Enter.

Notes:

- Dependencies: Make sure you have curl and vim installed on your system.
- Error Handling: The script checks for the presence of curl, the existence of directories, and whether the WEBHOOK_URL is set.
- URL Encoding: curl's --data-urlencode option is used to handle URL encoding of the title and content.
- GET Request Limitations: Be aware that GET requests have length limitations. If your notes are very long, you might want to modify the script to use a POST request instead.

Modification for POST Request (Optional)

If you decide to use a POST request due to GET limitations, replace the curl command with:

```
curl -X POST \
  --data-urlencode "title=$FILENAME" \
  --data-urlencode "content=$FILE_CONTENTS" \
  "$WEBHOOK_URL"
```

Pull requests welcome.
