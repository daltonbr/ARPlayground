#! /bin/sh

# Transfer a iOS Unity build (XCode project) to macbook over ssh
# We use RSA keys, to improve security and easy of use.

user="dli"
host="mbpdalton"
identity_file="~/.ssh/mbp_rsa"
project_path="/Users/dli/Projects/Playground/ARPlayground/Builds"
windows_path="/mnt/c/Dev/Unity/ARPlayground/Builds/Xcode" # wsl path

# ssh -i ~/.ssh/mbp_rsa dli@mbpdalton
# due to the ssh file copy, we need to edit the ownership permissions
scp -rp -i $identity_file $windows_path $user@$host":"$project_path
echo $project_path

# ssh dli@mbpdalton.fritz.box chmod +x /Users/dli/Projects/Playground/ARPlayground/Builds/Xcode/
ssh -i ~/.ssh/mbp_rsa dli@mbpdalton chmod +x $project_path"/Xcode/"

#TODO:
# 1. args to transfer only
# 2. transfer and compile (fastlane)
# 3. transfer, compile and submit to TestFlight

# how to handle provision and profiles?