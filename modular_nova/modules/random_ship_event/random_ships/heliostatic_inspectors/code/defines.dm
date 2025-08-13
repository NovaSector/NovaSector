/// Possible places/departments to inspect
#define INSPECTION_LIST list("Cargo","Command","Engineering","Medical","Science","Service","Security")

/// List of possible decorative job titles for additional roleplay potential
#define NRI_JOB_LIST list("NRI Safety Inspector","NRI Compliance Officer","NRI Station Surveyor","NRI Junior Inspector","NRI Safety Consultant","NRI Field Assessor","NRI Standards Examiner")

/// List of possible decorative leader job titles for additional roleplay potential
#define NRI_LEADER_JOB_LIST list("NRI Lead Inspector","NRI Senior Compliance Officer","NRI Chief Surveyor","NRI Inspection Supervisor","NRI Safety Director")

/// Amount of items to "confiscate", lower amount
#define CONFISCATE_LOWER 5
/// Amount of items to "confiscate", higher amount
#define CONFISCATE_HIGHER 15

/// To know whether or not we have an officer already
GLOBAL_VAR(first_officer)
