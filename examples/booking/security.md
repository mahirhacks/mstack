# Security: ClinicBook

- Status: Approved
- Last updated: 2026-10-12

## Data collected
| Category | Examples | Sensitivity | Source |
|---|---|---|---|
| Patient contact details | name, phone | medium | [U:I-7.1] |
| Appointment data | time, clinic | medium (reveals dental care) | [U:I-7.1] |
| Staff accounts | email | low | [U:I-7.1] |

No treatment notes or medical history are stored. [U:I-7.1]

## Login
- Patients: no account. They book with name and phone. [U:I-7.2]
- Staff: email magic link. MFA optional in v1. [U:I-7.2]

## Roles and permissions
| Role | Can | Must never | Source |
|---|---|---|---|
| Patient | book and cancel their own booking (via a signed link) | see other patients or bookings | [U:I-7.3] |
| Receptionist | manage their clinic's calendar | see other clinics' data | [U:I-7.3] |
| Owner | everything a receptionist can, plus reports | see other clinics' data | [U:I-7.3] |

## Compliance
| Regime | Applies? | Why | Source |
|---|---|---|---|
| GDPR (UK) | yes | UK patients | [U:I-7.4] |
| HIPAA | no | UK only, not a US covered entity | [U:I-7.4] |

## Retention and deletion
| Data | Kept for | User can delete? | Source |
|---|---|---|---|
| Patient contact + appointments | 24 months after the last appointment | yes, on request to the clinic | [U:I-7.5] |

## Threat model
- Threats of concern: data leak across clinics; SMS spam via the booking form; staff account takeover. [U:I-7.6]

## Decision record
<abridged in this example>
