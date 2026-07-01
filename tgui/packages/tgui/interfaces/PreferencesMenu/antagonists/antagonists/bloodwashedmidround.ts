import { type Antagonist, Category } from '../base';
import { BLOODWASHED_MECHANICAL_DESCRIPTION } from './bloodwashed';

const BloodwashedMidround: Antagonist = {
  key: 'bloodwashedmidround',
  name: 'Bloodwashed',
  description: [
    `
      A lone occult antagonist whose mind cracks open partway through the
      shift under lingering blood cult influence.
    `,
    BLOODWASHED_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default BloodwashedMidround;
