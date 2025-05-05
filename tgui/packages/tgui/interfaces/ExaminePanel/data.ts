// THIS IS A NOVA SECTOR UI FILE

export type ExaminePanelData = {
  // Danger, do not use
  assigned_map: string;
  // Identity
  character_name: string;
  headshot: string;
  obscured: boolean;
  // Descriptions
  flavor_text: string;
  ooc_notes: string;
  custom_species: string;
  custom_species_lore: string;
  // Descriptions, but requiring manual input to see
  flavor_text_nsfw: string;
  ooc_notes_nsfw: string;
  // Antaggery
  ideal_antag_optin_status: string;
  current_antag_optin_status: string;
  opt_in_colors: {
    optin: string;
    color: string;
  };
  // Misc
  veteran_status: boolean;
};
