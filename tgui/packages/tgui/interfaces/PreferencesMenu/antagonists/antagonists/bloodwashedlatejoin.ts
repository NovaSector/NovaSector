import { type Antagonist, Category } from '../base';

const BloodwashedLatejoin: Antagonist = {
  key: 'bloodwashedlatejoin',
  name: 'Bloodwashed',
  description: [
    `
      A lone occult antagonist touched by lingering blood cult influence,
      joining the shift already marked by Nar'Sie's echoes.
    `,

    `
      You have scraps of cult rites, limited blood magic, and your own
      objectives. You cannot convert others or summon Nar'Sie.
    `,
  ],
  category: Category.Latejoin,
};

export default BloodwashedLatejoin;
