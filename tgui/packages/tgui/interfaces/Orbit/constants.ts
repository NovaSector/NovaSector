export const ANTAG2COLOR = {
  Abductors: 'pink',
  'Ash Walkers': 'olive',
  Biohazards: 'brown',
  'Bounty Hunters': 'yellow',
  CentCom: 'teal',
  'Digital Anomalies': 'teal',
  'Emergency Response Team': 'teal',
  'Escaped Fugitives': 'orange',
  'Xenomorph Infestation': 'violet',
  'Spacetime Aberrations': 'white',
  'Deviant Crew': 'white',
  'Invasive Overgrowth': 'green',
} as const;

type Department = {
  color: string;
  trims: string[];
};

export const DEPARTMENT2COLOR: Record<string, Department> = {
  cargo: {
    color: 'brown',
    /* NOVA EDIT CHANGE START - ORIGINAL:
    trims: ['Bitrunner', 'Cargo Technician', 'Shaft Miner', 'Quartermaster'],
    */
    trims: [
      'Bitrunner',
      'Cargo Technician',
      'Customs Agent',
      'Shaft Miner',
      'Quartermaster',
    ],
  },
  command: {
    color: 'blue',
    // NOVA EDIT CHANGE START - ORIGINAL: trims: ['Captain', 'Head of Personnel'],
    trims: [
      'Captain',
      'Head of Personnel',
      'Nanotrasen Consultant',
      'Blueshield',
    ], // NOVA EDIT CHANGE END
  },
  engineering: {
    color: 'orange',
    /* NOVA EDIT CHANGE START - ORIGINAL:
    trims: ['Atmospheric Technician', 'Chief Engineer', 'Station Engineer'],
    */
    trims: [
      'Atmospheric Technician',
      'Chief Engineer',
      'Engineering Guard',
      'Station Engineer',
      'Telecomms Specialist',
    ], // NOVA EDIT CHANGE END
  },
  medical: {
    color: 'teal',
    trims: [
      'Chemist',
      'Chief Medical Officer',
      'Coroner',
      'Medical Doctor',
      'Paramedic',
      'Orderly', // NOVA EDIT ADDITION
      'Virologist', // NOVA EDIT ADDITION
    ],
  },
  science: {
    color: 'pink',
    /* NOVA EDIT CHANGE START - ORIGINAL:
    trims: ['Geneticist', 'Research Director', 'Roboticist', 'Scientist'],
    */
    trims: [
      'Geneticist',
      'Research Director',
      'Roboticist',
      'Science Guard',
      'Scientist',
    ], // NOVA EDIT CHANGE END
  },
  security: {
    color: 'red',
    /* NOVA EDIT CHANGE START - ORIGINAL:
    trims: ['Detective', 'Head of Security', 'Security Officer', 'Warden'],
    */
    trims: [
      'Corrections Officer',
      'Detective',
      'Head of Security',
      'Security Officer',
      'Warden',
    ], // NOVA EDIT CHANGE END
  },
  service: {
    color: 'green',
    trims: [
      'Bartender',
      'Botanist',
      'Chaplain',
      'Chef',
      'Clown',
      'Cook',
      'Curator',
      'Janitor',
      'Lawyer',
      'Mime',
      'Psychologist',
      'Barber', // NOVA EDIT ADDITION
      'Service Guard', // NOVA EDIT ADDITION
    ],
  },
};

export const THREAT = {
  Low: 1,
  Medium: 5,
  High: 8,
} as const;

export const HEALTH = {
  Good: 69, // nice
  Average: 19,
  Bad: 0,
  Crit: -30,
  Dead: -100,
  Ruined: -200,
} as const;

export const VIEWMODE = {
  Health: 'heart',
  Orbiters: 'ghost',
  Department: 'id-badge',
} as const;
