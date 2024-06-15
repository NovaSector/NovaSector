import { Feature, FeatureNumberInput } from '../base';

export const age: Feature<number> = {
  // name: 'Age', // ORIGINAL
  name: 'Age (Physical)', // NOVA EDIT CHANGE - Chronological age
  // NOVA EDIT ADDITION BEGIN - Chronological age
  description:
    "Physical age represents how far your character has grown physically and mentally.\
    Includes 'normal' aging, such as experiences which physically age the body, and 'anti-aging' medical procedures.\
    Does not include time spent in cryo-sleep.",
  // NOVA EDIT ADDITION END
  component: FeatureNumberInput,
};
