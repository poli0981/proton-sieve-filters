# AI Services filter -- filter/ai.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/ai.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# AI assistants, model providers and generative tools.
#
# Folders: AI
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 6 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if anyof (
    address :domain :matches "from" ["anthropic.com", "*.anthropic.com", "character.ai",
        "*.character.ai", "civitai.com", "*.civitai.com", "claude.ai", "*.claude.ai",
        "cohere.com", "*.cohere.com", "copy.ai", "*.copy.ai", "deepmind.com",
        "*.deepmind.com", "descript.com", "*.descript.com", "elevenlabs.io",
        "*.elevenlabs.io", "fireworks.ai", "*.fireworks.ai", "groq.com", "*.groq.com",
        "huggingface.co", "*.huggingface.co", "ideogram.ai", "*.ideogram.ai",
        "jasper.ai", "*.jasper.ai", "langchain.com", "*.langchain.com", "leonardo.ai",
        "*.leonardo.ai", "midjourney.com", "*.midjourney.com", "mistral.ai",
        "*.mistral.ai", "openai.com", "*.openai.com", "perplexity.ai",
        "*.perplexity.ai", "poe.com", "*.poe.com", "replicate.com", "*.replicate.com",
        "runwayml.com", "*.runwayml.com", "stability.ai", "*.stability.ai", "suno.com",
        "*.suno.com", "synthesia.io", "*.synthesia.io", "together.ai", "*.together.ai",
        "writesonic.com", "*.writesonic.com"],
    header :contains "subject" ["Usage Summary", "Credit Balance", "Model Update",
        "API Key", "Rate Limit", "New Model Available", "Beta Access", "Waitlist"]
) {
    addflag "\\Seen";
    fileinto "AI";
    expire "day" "30";

    stop;
}

# End of AI Services filter
