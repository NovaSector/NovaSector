import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Dropdown, Flex, Stack } from 'tgui-core/components'; // NOVA EDIT CHANGE - ORIGINAL: import { Button, Stack } from 'tgui-core/components';
import { exhaustiveCheck } from 'tgui-core/exhaustive';

import { PageButton } from '../components/PageButton';
import { PreferencesMenuData } from '../types';
import { AntagsPage } from './AntagsPage';
import { JobsPage } from './JobsPage';
// NOVA EDIT ADDITION START
import { LanguagesPage } from './LanguagesMenu';
import { LimbsPage } from './LimbsPage';
// NOVA EDIT ADDITION END
import { LoadoutPage } from './loadout';
import { MainPage } from './MainPage';
import { QuirksPage } from './QuirksPage';
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

  return (
    <Flex /* NOVA EDIT CHANGE START - Nova uses a dropdown instead of buttons */
      align="center"
      justify="center"
    >
      <Flex.Item width="25%">
        <Dropdown
          width="100%"
          selected={activeSlot as unknown as string}
          displayText={profiles[activeSlot]}
          options={profiles.map((profile, slot) => ({
            value: slot,
            displayText: profile ?? 'New Character',
          }))}
          onSelected={(slot) => {
            onClick(slot);
          }}
        />
      </Flex.Item>
    </Flex> /* NOVA EDIT CHANGE END */
  );
}

export function CharacterPreferenceWindow(props) {
  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPage, setCurrentPage] = useState(Page.Main);

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
      pageContents = <QuirksPage />;
      break;

    case Page.Loadout:
      pageContents = <LoadoutPage />;
      break;
    // NOVA EDIT ADDITION START
    case Page.Limbs:
      pageContents = <LimbsPage />;
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
              Quirks
            </PageButton>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item>{pageContents}</Stack.Item>
    </Stack>
  );
}
