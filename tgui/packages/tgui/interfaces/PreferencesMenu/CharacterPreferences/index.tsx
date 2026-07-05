import { useState, useMemo } from 'react'; // NOVA EDIT CHANGE - ORIGINAL: import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Dropdown, Stack } from 'tgui-core/components'; // NOVA EDIT CHANGE - ORIGINAL: import { Button, Stack } from 'tgui-core/components';
import { exhaustiveCheck } from 'tgui-core/exhaustive';

import { PageButton } from '../components/PageButton';
import type { PreferencesMenuData } from '../types';
import { AntagsPage } from './AntagsPage';
import { JobsPage } from './JobsPage';
// NOVA EDIT ADDITION START
import { LanguagesPage } from './LanguagesMenu';
import { AugmentsTab, LimbsPage } from './LimbsPage';
// NOVA EDIT ADDITION END
import { LoadoutPage } from './loadout';
import { MainPage } from './MainPage';
import { QuirkPersonalityPage } from './QuirksPage';
import { SpeciesPage } from './SpeciesPage';

enum Page {
  Antags,
  Main,
  Jobs,
  Species,
  Quirks,
  Loadout,
  // NOVA EDIT ADDITION START
  Limbs,
  Languages,
  // NOVA EDIT ADDITION END
}

type ProfileProps = {
  activeSlot: number;
  onClick: (index: number) => void;
  profiles: (string | null)[];
};

function CharacterProfiles(props: ProfileProps) {
  const { activeSlot, onClick, profiles } = props;
  // NOVA EDIT ADDITION START
  const firstEmptySlot = profiles.findIndex((profile) => !profile); // Index of the first null slot
  type CharacterOption = { value: number; displayText: string };
  const dropdownOptions = useMemo<CharacterOption[]>(() => {
    const emptySlots = profiles.filter((profile) => !profile).length;

    const characterOptions = profiles.reduce<CharacterOption[]>((options, profile, slot) => {
      if (profile) {
        options.push({ value: slot, displayText: profile });
      }
      return options;
    }, []);

    if (firstEmptySlot !== -1) {
      characterOptions.push({
        value: firstEmptySlot,
        displayText: `New Character (${emptySlots} slots left)`,
      });
    }

    return characterOptions;
  }, [profiles, firstEmptySlot]);
  // NOVA EDIT ADDITION END

  /* // NOVA EDIT REMOVAL START - Nova uses a dropdown instead of buttons
  return (
    <Stack justify="center" wrap>
      {profiles.map((profile, slot) => (
        <Stack.Item key={slot} mb={1}>
          <Button
            selected={slot === activeSlot}
            onClick={() => {
              onClick(slot);
            }}
            fluid
          >
            {profile ?? 'New Character'}
          </Button>
        </Stack.Item>
      ))}
    </Stack>
  );
}
  */ // NOVA EDIT REMOVAL END
  // NOVA EDIT ADDITION START
  return (
    <Stack
      align="center"
      justify="center"
    >
      <Stack.Item width="25%">
        <Dropdown
          width="100%"
          selected={activeSlot as unknown as string}
          displayText={profiles[activeSlot]}
          options={dropdownOptions}
          searchInput
          styledInput
          onSelected={(slot) => {
            onClick(slot);
          }}
        />
      </Stack.Item>
    </Stack>
  );
}
  // NOVA EDIT ADDITION END

/* // NOVA EDIT REMOVAL START
export function CharacterPreferenceWindow(props) {
  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPage, setCurrentPage] = useState(Page.Main);
*/ // NOVA EDIT REMOVAL END
// NOVA EDIT ADDITION START
export function CharacterPreferenceWindow(props: {
  onAugmentsTabChange?: (tab: import('./LimbsPage').AugmentsTab | null) => void;
}) {
  const { act, data } = useBackend<PreferencesMenuData>();
  const [augmentsTab, setAugmentsTab] = useState<AugmentsTab | null>(null);
  const [currentPage, setCurrentPageRaw] = useState(Page.Main);
  const setCurrentPage = (page: Page) => {
    if (page !== Page.Limbs) props.onAugmentsTabChange?.(null);
    else props.onAugmentsTabChange?.(AugmentsTab.Markings);
    document.querySelector('[style*="overflow"]')?.scrollTo(0, 0);
    setCurrentPageRaw(page);
  };
  // NOVA EDIT ADDITION END

  let pageContents;

  switch (currentPage) {
    case Page.Antags:
      pageContents = <AntagsPage />;
      break;
    case Page.Jobs:
      pageContents = <JobsPage />;
      break;
    case Page.Main:
      pageContents = (
        <MainPage openSpecies={() => setCurrentPage(Page.Species)} />
      );

      break;
    case Page.Species:
      pageContents = (
        <SpeciesPage closeSpecies={() => setCurrentPage(Page.Main)} />
      );

      break;
    case Page.Quirks:
      pageContents = <QuirkPersonalityPage />;
      break;

    case Page.Loadout:
      pageContents = <LoadoutPage />;
      break;
    // NOVA EDIT ADDITION START
    case Page.Limbs:
      pageContents = (
        <LimbsPage
          onTabChange={(tab) => {
            props.onAugmentsTabChange?.(tab);
            setAugmentsTab(tab);
          }}
        />
      );
      break;
    case Page.Languages:
      pageContents = <LanguagesPage />;
      break;
    // NOVA EDIT ADDITION END

    default:
      exhaustiveCheck(currentPage);
  }

  return (
    <Stack vertical fill>
      <Stack.Item>
        <CharacterProfiles
          activeSlot={data.active_slot - 1}
          onClick={(slot) => {
            act('change_slot', {
              slot: slot + 1,
            });
          }}
          profiles={data.character_profiles}
        />
      </Stack.Item>
      {!data.content_unlocked && (
        <Stack.Item align="center">
          Buy BYOND premium for more slots!
        </Stack.Item>
      )}
      <Stack.Divider />
      <Stack.Item>
        <Stack fill>
          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Main}
              setPage={setCurrentPage}
              otherActivePages={[Page.Species]}
            >
              Character
            </PageButton>
          </Stack.Item>

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Loadout}
              setPage={setCurrentPage}
            >
              Loadout
            </PageButton>
          </Stack.Item>

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Jobs}
              setPage={setCurrentPage}
            >
              {/*
                    Fun fact: This isn't "Jobs" so that it intentionally
                    catches your eyes, because it's really important!
                  */}
              Occupations
            </PageButton>
          </Stack.Item>
          {/* NOVA EDIT ADDITION START */}
          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Limbs}
              setPage={setCurrentPage}
            >
              Augments+
            </PageButton>
          </Stack.Item>

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Languages}
              setPage={setCurrentPage}
            >
              Languages
            </PageButton>
          </Stack.Item>
          {/* NOVA EDIT ADDITION end */}
          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Antags}
              setPage={setCurrentPage}
            >
              Antagonists
            </PageButton>
          </Stack.Item>

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Quirks}
              setPage={setCurrentPage}
            >
              Quirks and Personality
            </PageButton>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item grow position="relative" overflowX="hidden" overflowY="auto">
        {pageContents}
      </Stack.Item>
    </Stack>
  );
}
