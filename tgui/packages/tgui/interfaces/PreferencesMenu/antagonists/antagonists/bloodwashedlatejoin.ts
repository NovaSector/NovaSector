import { type Antagonist, Category } from '../base';
import { BLOODWASHED_MECHANICAL_DESCRIPTION } from './bloodwashed';

const BloodwashedLatejoin: Antagonist = {
  key: 'bloodwashedlatejoin',
  name: 'Bloodwashed',
  description: [
    `
      A lone occult antagonist touched by lingering blood cult influence,
      joining the shift already marked by Nar'Sie's echoes.
    `,
    BLOODWASHED_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Latejoin,
};

export default BloodwashedLatejoin;
