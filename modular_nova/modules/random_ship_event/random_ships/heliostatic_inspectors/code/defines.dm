/// Possible places/departments to inspect
#define INSPECTION_LIST list("Cargo","Command","Engineering","Medical","Science","Service","Security")

/// List of possible decorative job titles for additional roleplay potential
#define HC_JOB_LIST list("HC Safety Inspector","HC Compliance Officer","HC Station Surveyor","HC Junior Inspector","HC Safety Consultant","HC Field Assessor","HC Standards Examiner")

/// List of possible decorative leader job titles for additional roleplay potential
#define HC_LEADER_JOB_LIST list("HC Lead Inspector","HC Senior Compliance Officer","HC Chief Surveyor","HC Inspection Supervisor","HC Safety Director")

/// Amount of items to "confiscate", lower amount
#define CONFISCATE_LOWER 5
/// Amount of items to "confiscate", higher amount
#define CONFISCATE_HIGHER 15

/// To know whether or not we have an officer already
GLOBAL_VAR(first_officer)
