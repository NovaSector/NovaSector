// THIS IS A NOVA SECTOR UI FILE
import { useState } from 'react';
import {
  Button,
  Divider,
  Icon,
  Input,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { CharacterPreview } from './common/CharacterPreview';

const formatURLs = (text) => {
  if (!text) return;
  const parts = [];
  let regex = /https?:\/\/[^\s/$.?#].[^\s]*/gi;
  let lastIndex = 0;

  text.replace(regex, (url, index) => {
    parts.push(text.substring(lastIndex, index));
    parts.push(
      <a
        style={{
          color: '#0591e3',
          'text-decoration': 'none',
        }}
        href={url}
      >
        {url}
      </a>,
    );
    lastIndex = index + url.length;
    return url;
  });

  parts.push(text.substring(lastIndex));

  return <div>{parts}</div>;
};
const erpTagColor = {
  Unset: '#000000',
  'Top - Dom': '#410308',
  'Top - Switch': '#410308',
  'Top - Sub': '#410308',
  'Verse-Top - Dom': '#3d003b',
  'Verse-Top - Switch': '#3d003b',
  'Verse-Top - Sub': '#3d003b',
  'Verse - Dom': '#310042',
  'Verse - Switch': '#310042',
  'Verse - Sub': '#310042',
  'Verse-Bottom - Dom': '#29084b',
  'Verse-Bottom - Switch': '#29084b',
  'Verse-Bottom - Sub': '#29084b',
  'Bottom - Dom': '#002f51',
  'Bottom - Switch': '#002f51',
  'Bottom - Sub': '#002f51',
  'Check OOC Notes': '#333333',
  'Ask (L)OOC': '#333333',
  No: '#131313',
  Yes: '#002901',
};

export const NovaCharacterDirectory = (props) => {
  const { data } = useBackend();

  const {
    personalVisibility,
    personalAttraction,
    personalGender,
    personalErpTag,
    personalVoreTag,
    personalNonconTag,
    personalHypnoTag,
    assignedView,
    startViewing,
  } = data;

  const [overlay, setOverlay] = useState(null);
  const updateOverlay = (character) => {
    setOverlay(character);
  };

  const [searchTerm, setSearchTerm] = useState(startViewing || '');
  const updateSearchTerm = (character) => {
    setSearchTerm(character);
  };

  const [sortId, setSortId] = useState('name');
  const updateSortId = (character) => {
    setSortId(character);
  };
  const [sortOrder, setSortOrder] = useState('asc');
  const updateSortOrder = (character) => {
    setSortOrder(character);
  };

  const [colorCodeEnabled, setColorCodeEnabled] = useState('');
  const updateColorCodeEnabled = (character) => {
    setColorCodeEnabled(character);
  };

  return (
    <Window width={1000} height={800} resizeable>
      <Window.Content scrollable>
        {(overlay && (
          <ViewCharacter
            overlay={overlay}
            updateOverlay={updateOverlay}
            assignedView={assignedView}
          />
        )) || (
          <>
            <Section title="Your Preferences">
              <LabeledList>
                <LabeledList.Item label="Visibility">
                  <Button fluid>
                    {personalVisibility ? 'Shown' : 'Not Shown'}
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Attraction">
                  <Button fluid>{personalAttraction}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="Gender">
                  <Button fluid>{personalGender}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="ERP">
                  <Button fluid>{personalErpTag}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="Vore">
                  <Button fluid>{personalVoreTag}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="Hypnosis">
                  <Button fluid>{personalHypnoTag}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="Noncon">
                  <Button fluid>{personalNonconTag}</Button>
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <CharacterDirectoryList
              overlay={overlay}
              updateOverlay={updateOverlay}
              searchTerm={searchTerm}
              updateSearchTerm={updateSearchTerm}
              sortId={sortId}
              updateSortId={updateSortId}
              sortOrder={sortOrder}
              updateSortOrder={updateSortOrder}
              colorCodeEnabled={colorCodeEnabled}
              updateColorCodeEnabled={updateColorCodeEnabled}
            />
          </>
        )}
      </Window.Content>
    </Window>
  );
};

const ViewCharacter = (props) => {
  const { overlay, updateOverlay, assignedView } = props;

  return (
    <Stack fill>
      <Stack.Item>
        <Section height="375px" width="262px" title={overlay.name}>
          <CharacterPreview height="330px" width="250px" id={assignedView} />
        </Section>
        <Section title="Headshot">
          <img
            src={resolveAsset(overlay.headshot)}
            height="250px"
            width="250px"
          />
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Stack fill vertical>
          <Stack.Item grow>
            <Section
              minHeight="375px"
              scrollable
              fill
              title="Flavor Text:"
              preserveWhitespace
            >
              {formatURLs(overlay.flavor_text)}
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Stack fill>
              <Stack.Item grow>
                <Section
                  maxHeight="299px"
                  fill
                  scrollable
                  title="OOC Notes"
                  preserveWhitespace
                >
                  {overlay.ideal_antag_optin_status && (
                    <Stack.Item>
                      Current Antag Opt-In Status:{' '}
                      <span
                        style={{
                          fontWeight: 'bold',
                          color:
                            overlay.opt_in_colors[
                              overlay.current_antag_optin_status
                            ],
                        }}
                      >
                        {overlay.current_antag_optin_status}
                      </span>
                      {'\n'}
                      Antag Opt-In Status {'(Preferences)'}:{' '}
                      <span
                        style={{
                          color:
                            overlay.opt_in_colors[
                              overlay.ideal_antag_optin_status
                            ],
                        }}
                      >
                        {overlay.ideal_antag_optin_status}
                      </span>
                      {'\n\n'}
                    </Stack.Item>
                  )}
                  <LabeledList>
                    <LabeledList.Item label="Attraction">
                      {overlay.attraction}
                    </LabeledList.Item>
                    <LabeledList.Item label="Gender">
                      {overlay.gender}
                    </LabeledList.Item>
                    <LabeledList.Item label="ERP">
                      {overlay.erp}
                    </LabeledList.Item>
                    <LabeledList.Item label="Vore">
                      {overlay.vore}
                    </LabeledList.Item>
                    <LabeledList.Item label="Hypnosis">
                      {overlay.hypno}
                    </LabeledList.Item>
                    <LabeledList.Item label="Noncon">
                      {overlay.noncon}
                    </LabeledList.Item>
                  </LabeledList>
                  &nbsp; {formatURLs(overlay.ooc_notes)}
                </Section>
              </Stack.Item>
              <Stack.Item grow>
                <Section
                  maxHeight="299px"
                  fill
                  scrollable
                  title="Character Advert"
                >
                  {overlay.character_ad}
                </Section>
                <NoticeBox align="right" info>
                  <Button
                    align="right"
                    color="good"
                    icon="arrow-left"
                    onClick={() => updateOverlay(null)}
                  >
                    Back
                  </Button>
                </NoticeBox>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const CharacterDirectoryList = (props) => {
  const { act, data } = useBackend();
  const {
    updateOverlay,
    searchTerm,
    updateSearchTerm,
    sortId,
    updateSortId,
    sortOrder,
    updateSortOrder,
    colorCodeEnabled,
    updateColorCodeEnabled,
  } = props;

  const { directory, canOrbit, assignedView } = data;

  const handleSort = (id) => {
    if (sortId === id) {
      updateSortOrder(sortOrder === 'asc' ? 'desc' : 'asc');
    } else {
      updateSortId(id);
      updateSortOrder('asc');
    }
  };

  const handleRandomView = () => {
    if (directory.length > 0) {
      const randomIndex = Math.floor(Math.random() * directory.length);
      const randomCharacter = directory[randomIndex];
      updateOverlay(randomCharacter);
      act('view_character', {
        assigned_view: assignedView,
        name: randomCharacter.appearance_name,
      });
    }
  };

  const filteredDirectory = directory.filter((character) =>
    character.name.toLowerCase().includes(searchTerm.toLowerCase()),
  );

  const sortedDirectory = filteredDirectory.slice().sort((a, b) => {
    const sortOrderValue = sortOrder === 'asc' ? 1 : -1;
    return sortOrderValue * a[sortId].localeCompare(b[sortId]);
  });

  return (
    <Section
      title="Directory"
      buttons={
        <>
          <Button icon="sync" onClick={() => act('refresh')}>
            Refresh
          </Button>
          <Tooltip content="Display a random player's advert. Click if you dare.">
            <Button icon="random" onClick={handleRandomView}>
              I Feel Lucky
            </Button>
          </Tooltip>
        </>
      }
    >
      <Stack mb={-2}>
        <Stack.Item>
          <Input
            placeholder="Search name..."
            onInput={(e, value) => {
              updateSearchTerm(value);
            }}
            value={searchTerm}
            mb={2}
          />
        </Stack.Item>
        <Stack.Divider hidden grow width="50%" />
        <Stack.Item>
          <Button.Checkbox
            checked={colorCodeEnabled}
            onClick={(e) => {
              updateColorCodeEnabled(!colorCodeEnabled);
            }}
            tooltip="Toggles the color coding for ERP Status."
          >
            ERP Status Colors
          </Button.Checkbox>
        </Stack.Item>
      </Stack>
      <Divider />
      <Table>
        <Table.Row bold>
          <SortButton
            id="name"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Name
          </SortButton>
          <SortButton
            id="species"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Species
          </SortButton>
          <SortButton
            id="attraction"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Attraction
          </SortButton>
          <SortButton
            id="gender"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Gender
          </SortButton>
          <SortButton
            id="erp"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            ERP
          </SortButton>
          <SortButton
            id="vore"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Vore
          </SortButton>
          <SortButton
            id="hypno"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Hypno
          </SortButton>
          <SortButton
            id="noncon"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Noncon
          </SortButton>
          <Table.Cell collapsing textAlign="right">
            Advert
          </Table.Cell>
        </Table.Row>
        {sortedDirectory.map((character, i) => (
          <Table.Row
            key={i}
            backgroundColor={
              colorCodeEnabled ? erpTagColor[character.erp] : 'transparent'
            }
          >
            <Table.Cell p={1}>
              {canOrbit ? (
                <Button
                  color={erpTagColor[character.erp]}
                  icon="ghost"
                  tooltip="Orbit"
                  onClick={() => act('orbit', { ref: character.ref })}
                >
                  {character.name}
                </Button>
              ) : (
                character.name
              )}
            </Table.Cell>
            <Table.Cell>{character.species}</Table.Cell>
            <Table.Cell>{character.attraction}</Table.Cell>
            <Table.Cell>{character.gender}</Table.Cell>
            <Table.Cell>{character.erp}</Table.Cell>
            <Table.Cell>{character.vore}</Table.Cell>
            <Table.Cell>{character.hypno}</Table.Cell>
            <Table.Cell>{character.noncon}</Table.Cell>
            <Table.Cell collapsing textAlign="right">
              <Button
                onClick={() => {
                  updateOverlay(character);
                  act('view_character', {
                    assigned_view: assignedView,
                    name: character.appearance_name,
                  });
                }}
                color="transparent"
                icon="sticky-note"
                mr={1}
              >
                View
              </Button>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const SortButton = ({ id, sortId, sortOrder, onClick, children }) => (
  <Table.Cell collapsing>
    <Button
      width="100%"
      color={sortId !== id ? 'transparent' : undefined}
      onClick={() => onClick(id)}
    >
      {children}
      {sortId === id && (
        <Icon
          name={sortOrder === 'asc' ? 'sort-up' : 'sort-down'}
          ml="0.25rem;"
        />
      )}
    </Button>
  </Table.Cell>
);
