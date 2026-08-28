"""Proton Mail's Sieve dialect, in one place.

Sources: https://proton.me/support/sieve-advanced-custom-filters
         https://proton.me/support/email-inbox-filters
"""

# Extensions Proton accepts in a `require` statement.
SUPPORTED_EXTENSIONS = {
    "fileinto",
    "imap4flags",
    "reject",
    "vacation",
    "date",
    "envelope",
    "variables",
    "relational",
    "regex",
    "comparator-i;ascii-numeric",
    "extlists",
    "include",
    "vnd.proton.eval",
    "vnd.proton.expire",
}

# Tests Proton supports. Notably absent: `body` -- zero-access encryption means
# the server never sees message content, only headers, envelope and encrypted
# size.
SUPPORTED_TESTS = {
    "currentdate", "date", "hasflag", "envelope", "address", "header",
    "hasexpiration", "exists", "expiration", "size", "string",
    "anyof", "allof", "not", "true", "false", "valid_ext_list",
}

# Core RFC 5228 commands. These need no `require`; naming one in a require
# statement makes a strict interpreter reject the entire script.
CORE_COMMANDS = {"if", "elsif", "else", "require", "stop", "keep", "discard", "redirect"}

# Regex shorthand Sieve does not support (POSIX classes only).
UNSUPPORTED_REGEX_SHORTHAND = (r"\b", r"\w", r"\W", r"\d", r"\D", r"\s", r"\S")

# Plan limits.
MAX_ACTIVE_FILTERS_PAID = 250
MAX_ACTIVE_FILTERS_FREE = 1

# vnd.proton.expire accepts at most 730 days.
MAX_EXPIRE_DAYS = 730
