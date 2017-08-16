# WordPress Bulk Email Update Scripts
Bash scripts for bulk updating WordPress user email addresses and blog admin email addresses.

These are designed for a project where I migrated corporate users one domain to another but their usernames remained the same.

These scripts are free to use and modify as you want and come with no support.

## Basic Configuration

These are bash scripts that pull your DB information from the wp-config.php file.

You need to configure your old and new domains.

Change this line to include your new email domain.
```
newemaildomain="@github.com";
```
Change the domain listed in the if statement to you old domain you are migrating from.
```
if [[ $email == *github.com ]]; then
```

## Running the scripts

Copy the scripts to your server with the required updates, chmod them to allow execution and then run them.

```
./wp-bulk-update-user-emails.sh
./wp-bulk-update-blog-admin-emails/sh
```
