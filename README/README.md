# Proton Sieve Filters

A collection of Sieve scripts for advanced email filtering in Proton Mail. This repository includes various filters such as social media notifications (the first filter), invoices, advertisements, and more. Customize them to organize your inbox efficiently.

## Description
This repo provides ready-to-use Sieve scripts for Proton Mail users. Sieve is a domain-specific language (DSL) for server-side email filtering, allowing actions like moving emails, marking as read, or expiring them. The social media filter is the starting point, with extensions for other categories.

**Note on Domains**: The lists of domains for different filters (e.g., social media, invoices) are stored in 'domains.txt'. You can edit this file to add or remove domains without modifying the scripts.

## Usage
1. Log in to Proton Mail → Settings → Filters → Add Sieve Filter.
2. Copy the script from a .sieve file (e.g., filters/social_media.sieve) and paste it.
3. Customize domains in 'domains.txt' if needed.
4. Test with sample emails.

**Available Filters**:
- Social Media: Filters notifications from X, Facebook, etc. (first filter in the repo).
- Invoices: Moves billing emails from PayPal, Amazon, etc.
- Advertisements: Handles promo emails.
- More to come...

## Limitations
- These scripts are optimized for Proton Mail and may require modifications for other email services (e.g., remove Proton-specific extensions like "vnd.proton.expire").
- Basic programming knowledge in Sieve (or similar scripting) is recommended for customization, as errors can lead to missed or rejected emails.
- Filters apply only to incoming emails; they do not retroactively organize existing messages.
- Potential risks: Overbroad rules might cause false positives (e.g., rejecting important emails); always test thoroughly.
- No warranty: Use at your own risk, as per open source standards.

## Contributing
Fork the repo, add new filters or domains, and submit a pull request. Follow Semantic Versioning for updates (e.g., v0.1.0).

## License
MIT License - Feel free to use and modify.