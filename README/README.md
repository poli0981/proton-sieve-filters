# Proton Sieve Filters

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GitHub contributors](https://img.shields.io/badge/Contributors-Welcome-brightgreen.svg)](https://github.com/poli0981/proton-sieve-filters/graphs/contributors)
[![GitHub issues](https://img.shields.io/github/issues/poli0981/proton-sieve-filters.svg)](https://github.com/poli0981/proton-sieve-filters/issues)
[![Version](https://img.shields.io/badge/Version-0.2.0-blue.svg)](https://github.com/poli0981/proton-sieve-filters/releases)

## 📧 Description

This repository provides comprehensive Sieve email filtering scripts specifically designed for Proton Mail users. Sieve is a domain-specific language (DSL) for server-side email filtering, enabling automated actions like categorizing emails, marking as read, setting expiration dates, and organizing your inbox efficiently.

**🤖 AI-Assisted Development**: This project was developed with AI assistance for research, script writing, bug fixes, and translation. The final implementation was reviewed and refined by [@poli0981](https://github.com/poli0981).

**Development Contribution Ratio:**
- **👨‍💻 Human (@poli0981): 35%** - Project concept, script architecture, AI prompt engineering, bug fixes, Vietnamese language content, quality assurance
- **🤖 AI (GitHub Copilot/Claude Sonnet 4 & Grok 4): 65%** - Script implementation, translations, research, documentation, domain/keyword compilation

## ⚠️ Critical Setup Requirements

**🚨 IMPORTANT**: Before using these filters, you MUST create the target folders in your Proton Mail account first. **The scripts will NOT work if the folders don't exist.**

### Required Folders to Create:
```
📁 Shopping
📁 Travel  
📁 Work
📁 Security
📁 Entertainment
📁 Gaming
📁 Social
📁 Invoices
📁 Newsletters
📁 Health
📁 Study
📁 Proton
📁 Spam_Filter
📁 EULA
```

**How to Create Folders in Proton Mail:**
1. Go to **Settings** → **Folders and labels**
2. Click **Add folder**
3. Create each folder listed above
4. **Only then** install the Sieve filters

## 🚀 Key Features

- **🎯 15+ Specialized Filters**: Comprehensive email categorization for all aspects of digital life
- **📱 Easy Installation**: Copy-paste scripts directly into Proton Mail
- **⚙️ Fully Customizable**: Edit domains, keywords, and retention periods
- **🌍 Multi-Language Support**: Keywords in English, Vietnamese, Chinese, and Japanese
- **⏰ Smart Retention**: Automatic email expiration based on importance
- **🔒 Security-Focused**: Enhanced spam detection and security alert prioritization

## 📂 Available Filters (Version 0.2.0)

| Filter | Purpose | Keywords | Domains | Retention |
|--------|---------|----------|---------|-----------|
| **🛒 Shopping** | E-commerce, deals, purchases | 200+ | 200+ | 1-365 days |
| **✈️ Travel** | Bookings, flights, hotels | 150+ | 200+ | 1-90 days |
| **💼 Work** | Professional, business | 200+ | 150+ | 1-365 days |
| **🔐 Security** | Account alerts, 2FA, breaches | 200+ | - | 1-365 days |
| **🎮 Gaming** | Games, platforms, news | 150+ | 100+ | 1-30 days |
| **📺 Entertainment** | Streaming, media, events | 120+ | 80+ | 1-14 days |
| **📱 Social Media** | Social networks, notifications | 100+ | 60+ | 1-7 days |
| **💰 Invoices** | Bills, payments, receipts | 80+ | 70+ | 30-365 days |
| **📰 Newsletters** | News, updates, subscriptions | 60+ | 50+ | 1-30 days |
| **🏥 Health** | Medical, fitness, wellness | 100+ | 60+ | 7-90 days |
| **📚 Study** | Education, courses, learning | 80+ | 40+ | 7-180 days |
| **⚗️ Proton** | Proton services notifications | 40+ | - | 30-90 days |
| **🚫 Spam** | Advanced spam detection | 150+ | - | Immediate deletion |
| **📜 EULA** | Terms, policies, legal updates | 30+ | - | 90 days |

## 📥 Installation Guide

### Step 1: Create Required Folders
1. Log into your **Proton Mail** account
2. Navigate to **Settings** → **Folders and labels**
3. Create all folders listed in the "Required Folders" section above

### Step 2: Install Filters
1. Go to **Settings** → **Filters** → **Add Sieve Filter**
2. Choose a filter from the `filter/` directory (e.g., `shopping.sieve`)
3. Copy the entire script content
4. Paste into Proton Mail's Sieve filter editor
5. Give it a descriptive name (e.g., "Shopping Filter v0.2.0")
6. **Test first** with a few emails before full activation
7. Save and activate the filter

### Step 3: Customization (Optional)
- Edit domain lists in the script files
- Modify keywords for your language/region
- Adjust retention periods based on your needs
- Add personal email addresses to whitelists

## 🗂️ Project Structure

```
proton-sieve-filters/
├── 📁 filter/                     # Main Sieve filter scripts
│   ├── shopping.sieve            # E-commerce & shopping
│   ├── TravelFilters.sieve       # Travel & booking
│   ├── work_filter.sieve         # Professional emails
│   ├── SecurityAccount_filter.sieve # Security alerts
│   ├── game_filter.sieve         # Gaming platforms
│   ├── entertainment_filter.sieve # Entertainment content
│   ├── social_media_filter.sieve # Social networks
│   ├── invoice_filter.sieve      # Bills & payments
│   ├── newsletter.sieve          # Newsletters & news
│   ├── healthAndFitness.sieve    # Health & wellness
│   ├── study_filter.sieve        # Education & learning
│   ├── proton_notification.sieve # Proton services
│   ├── spam_filter.sieve         # Spam detection
│   └── EULAChange_filter.sieve   # Legal updates
├── 📁 keyword/                    # Keyword reference files
│   ├── shopping_keyword.md       # Shopping keywords guide
│   ├── travel_keyword.md         # Travel keywords guide
│   ├── work_keyword.md           # Work keywords guide
│   ├── security_keyword.md       # Security keywords guide
│   └── ... (more keyword guides)
├── 📁 domain/                     # Domain reference files
│   ├── shopping.md               # Shopping domains list
│   ├── travel.md                 # Travel domains list
│   ├── work_domain.md            # Work domains list
│   └── ... (more domain lists)
├── 📁 README/                     # Multi-language documentation
│   ├── README.md                 # English (this file)
│   ├── README_vi.md              # Vietnamese version
│   ├── README_zh.md              # Chinese version
│   └── README_ja.md              # Japanese version
└── LICENSE                        # MIT License
```

## 🛠️ Advanced Customization

### Adding Custom Domains
```sieve
# Add to any filter script
if header :contains "from" "yourdomain.com" {
    fileinto "YourFolder";
    addflag "\\Seen";
    stop;
}
```

### Adjusting Retention Periods
```sieve
# Modify expire times (in days)
expire "day" "30";  # 30 days
expire "day" "90";  # 90 days
expire "day" "365"; # 1 year
```

### Whitelisting Important Contacts
All filters include personal contact whitelist:
```sieve
if anyof (
    header :list "from" ":addrbook:myself"
) {
    stop;
}
```

## 🧪 Testing Your Filters

### Before Production Deployment:
1. **Start Small**: Activate one filter at a time
2. **Monitor Activity**: Check filter logs for 24-48 hours
3. **Verify Folders**: Ensure emails are sorted correctly
4. **Check False Positives**: Review filtered emails daily initially
5. **Adjust Rules**: Fine-tune domains and keywords as needed

### Testing Checklist:
- [ ] All required folders created
- [ ] Filter syntax validates without errors
- [ ] Test emails route to correct folders
- [ ] Important emails not incorrectly filtered
- [ ] Retention periods work as expected
- [ ] Whitelist protects personal contacts

## 🚨 Troubleshooting

### Common Issues:

**Filter Not Working**
- ✅ Verify all target folders exist
- ✅ Check Sieve syntax for errors
- ✅ Ensure filter is activated
- ✅ Test with sample emails

**Important Emails Being Filtered**
- ✅ Add sender to personal addressbook (whitelist)
- ✅ Review and refine domain/keyword lists
- ✅ Check filter order priority

**Emails Going to Wrong Folders**
- ✅ Review filter conditions
- ✅ Check for conflicting rules
- ✅ Verify folder names match script exactly

## 🤝 Contributing

We welcome contributions! To contribute:

1. **Fork** the repository
2. **Create** a new branch: `git checkout -b feature/amazing-feature`
3. **Add** new filters, domains, or keywords
4. **Test thoroughly** with sample emails
5. **Follow** semantic versioning (e.g., `v0.3.0`)
6. **Submit** a pull request with detailed description

### Contribution Guidelines:
- Follow existing code style and structure
- Include comprehensive testing
- Document new features in README
- Respect the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/0/code_of_conduct.html)

## ⚠️ Limitations & Disclaimers

### Technical Limitations:
- **Proton Mail Specific**: Uses Proton-specific Sieve extensions
- **Folder Dependency**: Requires manual folder creation
- **New Emails Only**: Doesn't reorganize existing emails
- **Basic Sieve Knowledge**: Customization requires understanding of Sieve syntax

### Important Disclaimers:
- **No Warranty**: Use at your own risk per MIT license
- **Testing Required**: Always test before production use
- **False Positives**: Overly broad rules may filter important emails
- **Manual Review**: Regularly review filtered emails initially
- **Backup Strategy**: Keep important emails backed up

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License - Free to use, modify, and distribute
Attribution required when redistributing
No warranty provided - use at your own risk
```

## 👨‍💻 Contact & Support

- **GitHub**: [@poli0981](https://github.com/poli0981)
- **X (Twitter)**: [@SkullMute0011](https://x.com/SkullMute0011)
- **Facebook**: [skull.loro](https://www.facebook.com/skull.loro)
- **Email**: coding201913@hotmail.com

### Getting Help:
1. Check existing [GitHub Issues](https://github.com/poli0981/proton-sieve-filters/issues)
2. Review [Proton Mail Sieve Documentation](https://proton.me/support/sieve-advanced-custom-filters)
3. Post detailed issue with sample emails and error messages
4. Contact maintainer for complex problems

## 🙏 Acknowledgments

- **🤖 AI Assistance**: GitHub Copilot (Claude Sonnet 4) & Grok 4 for development support
- **📧 Inspiration**: Proton Mail community's need for advanced email filtering
- **🌐 Community**: Contributors, testers, and users who improve these filters
- **📚 Resources**: Sieve RFC documentation and Proton Mail technical guides

## 🔗 Useful Resources

- **Proton Mail Sieve Guide**: [Official Documentation](https://proton.me/support/sieve-advanced-custom-filters)
- **Sieve RFC**: [RFC 5228 Specification](https://tools.ietf.org/html/rfc5228)
- **Regex Testing**: [RegExr](https://regexr.com/) for pattern testing
- **Email Testing**: [Mail Tester](https://www.mail-tester.com/) for spam score checking

---

**⚠️ Important**: When using or redistributing this code, please credit the original repository and author.

**🔗 Repository**: https://github.com/poli0981/proton-sieve-filters  
**📊 Version**: 0.2.0  
**📅 Last Updated**: August 17, 2025  
**👥 Contributions**: Welcome and appreciated!

---

*Happy Email Filtering! 📧✨*