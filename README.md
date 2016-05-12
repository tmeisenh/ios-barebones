# ios-barebones
Collection of files that I like to use when starting new iOS projects.

##### Makefile 
The Makefile requires [xcpretty](https://github.com/supermarin/xcpretty).
You might have to escape the parentheses if invoking make from a login shell.

example:
```shell
make clean build sign CODE_SIGN_IDENTITY="iPhone Developer: youremail@email.com \(gobbledygook\)" PROVISIONING_PROFILE="/some/full/path/some_uuid.mobileprovision"
```

If you get weird errors about "Warning: --resource-rules has been deprecated in Mac OS X >= 10.10!" then you need to open the "Build Settings" tab of your project and find the key "Code Signing Resource Rules Path" and set its value to $(SDKROOT)/ResourceRules.plist.  Odds are that key has no value.
