# Proton Sieve Filters

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GitHub contributors](https://img.shields.io/github/contributors/poli0981/proton-sieve-filters.svg)](https://github.com/poli0981/protonmail-sieve-filters/graphs/contributors)
[![GitHub issues](https://img.shields.io/github/issues/poli0981/proton-sieve-filters.svg)](https://github.com/poli0981/protonmail-sieve-filters/issues)

## Description

This repository provides pre-built Sieve scripts for Proton Mail users. Sieve is a domain-specific language (DSL) for server-side email filtering, allowing actions like moving emails, marking as read, or expiring them. Multiple filters are available for different categories like gaming, social media, invoices, advertisements, and more.

This is a solo project with AI assistance in script development. AI models used: Grok 4 & GitHub Copilot (powered by Claude Sonnet 4).

**Note on Domains**: The lists of domains for different filters (e.g., social media, invoices, gaming) are integrated directly into the scripts. You can edit the script files to add or remove domains as needed.

## Key Features

- **Comprehensive Email Filtering**: Pre-built filters for gaming, social media, invoices, advertisements, and spam detection
- **Easy to Use**: Simply copy and paste scripts into Proton Mail's Sieve filter editor
- **Customizable**: Edit domain lists and keywords directly in the script files
- **New Emails Only**: Scripts apply only to incoming emails; existing emails are not affected
- **Available Filters**:
  - **Gaming**: Filters emails from gaming platforms, publishers, news sites, esports organizations, and mobile games
  - **Social Media**: Filters notifications from platforms like X (Twitter), Facebook, Instagram, etc.
  - **Invoices**: Moves billing-related emails from services like PayPal, Amazon, Stripe, etc.
  - **Advertisements**: Manages promotional and marketing emails with comprehensive spam detection
  - More filters coming soon...

## Usage Instructions

1. Log in to your Proton Mail account
2. Navigate to **Settings** > **Filters** > **Add Sieve Filter**
3. Copy the script from a `.sieve` file in the `filter/` directory (e.g., `filter/game_filter.sieve`)
4. Paste the script into the filter editor
5. Customize domains or keywords directly in the script if needed
6. Test the filter with sample emails to ensure it works as expected
7. Save and activate the filter

## Installation

No installation required. Simply clone the repository and use the scripts directly:

```bash
git clone https://github.com/poli0981/proton-sieve-filters.git
cd proton-sieve-filters
```

## File Structure (Current):

```
proton-sieve-filters/
├── filter/
│   ├── game_filter.sieve          # Gaming-related email filter
│   ├── social_media_filter.sieve  # Social media notifications filter
│   ├── invoice_filter.sieve       # Billing and invoice filter
│   └── advertisement_filter.sieve # Promotional email filter
├── README/
│   └── README.md                  # This file
└── LICENSE                        # MIT License
```

## Script Features

### Gaming Filter (`game_filter.sieve`)
- Filters emails from major gaming platforms (Steam, Epic Games, GOG, etc.)
- Includes gaming news sites (IGN, GameSpot, Polygon, etc.)
- Covers esports organizations and mobile gaming companies
- Auto-expires promotional emails after 9 days
- Marks emails as read automatically

### Social Media Filter
- Handles notifications from major social platforms
- Organizes social media communications efficiently

### Invoice Filter
- Captures billing emails from payment processors
- Organizes financial communications

### Advertisement Filter
- Comprehensive spam detection with 100+ keywords
- Rejects obvious spam and promotional content

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a new branch for your feature or bug fix
3. Add new filters, domains, or improvements
4. Follow Semantic Versioning (e.g., `v0.1.0`) for updates
5. Submit a pull request with a clear description of changes

Please adhere to the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/0/code_of_conduct.html).

## Limitations

- **Proton Mail Specific**: Scripts are optimized for Proton Mail and may require modifications for other email services (e.g., removing Proton-specific extensions like `vnd.proton.expire`)
- **Technical Knowledge**: Basic understanding of Sieve scripting is recommended for customization, as errors could lead to missed or rejected emails
- **New Emails Only**: Filters apply only to incoming emails; they do not reorganize existing emails
- **Potential Risks**: Overly broad rules may cause false positives (e.g., rejecting important emails). Always test thoroughly
- **No Warranty**: Use at your own risk, as per open-source standards

## Testing Your Filters

Before deploying filters in production:

1. Test with a few sample emails first
2. Monitor the filter activity for the first few days
3. Check both the target folder and spam folder to ensure proper sorting
4. Adjust domain lists and keywords as needed

## Troubleshooting

**Common Issues:**
- **Emails not filtering**: Check for syntax errors in the script
- **Important emails being filtered**: Review and refine your domain/keyword lists
- **Filter not activating**: Ensure the script is properly saved and activated in Proton Mail

**Getting Help:**
- Check the Issues section on GitHub
- Review Proton Mail's Sieve documentation
- Contact the maintainer via the methods below

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. Feel free to use and modify, but please attribute the source and author when redistributing.

## Contact

- **GitHub**: [poli0981](https://github.com/poli0981)
- **X (Twitter)**: [@SkullMute0011](https://x.com/SkullMute0011)
- **Facebook**: [skull.loro](https://www.facebook.com/skull.loro)
- **Email**: coding201913@hotmail.com

## Acknowledgments

- **Powered by AI**: GitHub Copilot (Claude Sonnet 4) & Grok 4
- **Inspired by**: The need for efficient email management in Proton Mail
- **Community**: Thanks to all contributors and users who help improve these filters

---

**⚠️ Important**: When using or redistributing the source code, please credit the original repository and author.

**🔗 Repository**: https://github.com/poli0981/proton-sieve-filters