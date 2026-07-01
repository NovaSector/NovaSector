import { type Antagonist, Category } from '../base';

export const BLOODWASHED_MECHANICAL_DESCRIPTION = `
      You have scraps of cult rites, limited blood magic, and your own
      objectives. You cannot convert others or summon Nar'Sie.
`;

const Bloodwashed: Antagonist = {
  key: 'bloodwashed',
  name: 'Bloodwashed',
  description: [
    `
      A lone occult antagonist touched by lingering blood cult influence.
      This option controls roundstart Bloodwashed selection.
    `,
    BLOODWASHED_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Bloodwashed;
