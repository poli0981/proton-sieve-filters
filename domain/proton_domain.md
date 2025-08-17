# Proton Domains for Email Filtering

> **📝 Important Notes:**
> - These domains are official Proton services and should be trusted for filtering
> - Domain patterns use wildcards (*) to match subdomains
> - All domains are verified as legitimate Proton-owned properties
> - You can customize this list based on your specific Proton services usage

## 📋 Domain Categories

| Category | Count | Description |
|----------|-------|-------------|
| **Core Proton** | 6 domains | Main email and account services |
| **Service-Specific** | 4 domains | Individual product domains |
| **Regional** | 2 domains | Country-specific domains |

---

## 🌐 Official Proton Domains

### Core Proton Services
```
*.proton.me           # Primary Proton domain
*.protonmail.com      # Legacy ProtonMail domain
*.pm.me               # Short domain for Proton Mail
```

### Regional Domains
```
*.proton.ch           # Switzerland-based domain
*.protonmail.ch       # Legacy Swiss domain
```

### Service-Specific Domains
```
*.protonstatus.com    # Service status and uptime monitoring
*.protonvpn.com       # Proton VPN service
*.protoncalendar.com  # Proton Calendar service
*.protondrive.com     # Proton Drive service
```

---

## 📧 Sender Email Patterns

### Official Sender Addresses
```
noreply@proton.me
no-reply@proton.me
notifications@proton.me
support@proton.me
security@proton.me
billing@proton.me
newsletter@proton.me
updates@proton.me
community@proton.me
feedback@proton.me
survey@proton.me
```

### Service-Specific Senders
```
*@protonstatus.com
*@protonvpn.com
*@protoncalendar.com
*@protondrive.com
```

---

## 🔒 Security Considerations

### Trusted Domains Only
- All listed domains are officially owned by Proton
- Beware of similar-looking domains (typosquatting)
- Always verify sender authenticity for security alerts

### Common Spoofing Attempts
⚠️ **Avoid these fake domains:**
```
proton-mail.com    # Missing 'mail' in official domain
pr0ton.me          # Zero instead of 'o'
protonmai1.com     # Number '1' instead of 'l'
proton.com         # Missing '.me' extension
```

### Domain Verification
- Check DKIM signatures for authenticity
- Verify SPF records match official Proton infrastructure
- Look for HTTPS certificates from legitimate Certificate Authorities

---

## 🛠️ Implementation Notes

### Sieve Filter Usage
```sieve
# Use wildcard matching for subdomains
address :domain :matches "from" ["*.proton.me", "*.protonmail.com"]

# Specific sender matching
header :contains "from" ["noreply@proton.me", "support@proton.me"]
```

### Whitelist Recommendations
- Add all official Proton domains to your whitelist
- Configure spam filters to never block these domains
- Set up separate rules for different Proton services

### Regular Updates
- Monitor Proton's official announcements for new domains
- Update filter rules when new services launch
- Remove deprecated domains when officially sunset

---

## 📈 Service Coverage

### Current Proton Services
- **Proton Mail**: Email service (proton.me, protonmail.com)
- **Proton VPN**: VPN service (protonvpn.com)
- **Proton Drive**: Cloud storage (protondrive.com)
- **Proton Calendar**: Calendar service (protoncalendar.com)
- **Proton Pass**: Password manager (notifications via main domains)

### Future Services
- Monitor Proton's roadmap for new services
- New domains may be added for upcoming products
- Beta services may use existing domain infrastructure

---

## 🔄 Maintenance Schedule

### Monthly Review
- Check for new official Proton domains
- Verify all domains are still active
- Update filter rules if needed

### Quarterly Audit
- Review email filtering effectiveness
- Analyze false positives/negatives
- Adjust retention periods based on usage

### Annual Update
- Complete domain list review
- Update security considerations
- Refresh implementation guidelines

---

*Last updated: August 17, 2025*
*Domain list version: 0.2.0*