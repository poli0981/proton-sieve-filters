# Sieve filter
# Test.sieve
# Only for user use Proton Mail
# Version: 0.2.0
# This Sieve script is a placeholder for testing purposes.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Delete messages if they are in the spam list
if header :list "from" ":incomingdefaults:spam" {
        discard;
        stop;
}

if anyof (
    # Test
    address :domain :matches "from" ["*example.com", "*test.com", "*demo.com"]
) {
    # Move to "Payments" folder first
    fileinto "Test";
    
    # Mark as read
    addflag "\\Seen";

}