// THIS IS A NOVA SECTOR UI FILE
import { useState } from 'react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import {
  Button,
  Icon,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
} from '../components';
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
  'Top - Dom': '#b00900',
  'Top - Switch': '#9e0800',
  'Top - Sub': '#940700',
  'Verse-Top - Dom': '#b000a1',
  'Verse-Top - Switch': '#a30095',
  'Verse-Top - Sub': '#940088',
  'Verse - Dom': '#6500a3',
  'Verse - Switch': '#5b0094',
  'Verse - Sub': '#6d00b0',
  'Verse-Bottom - Dom': '#070094',
  'Verse-Bottom - Switch': '#0900a3',
  'Verse-Bottom - Sub': '#0900b0',
  'Bottom - Dom': '#006794',
  'Bottom - Switch': '#0072a3',
  'Bottom - Sub': '#0084bd',
  'Check OOC Notes': '#333333',
  'Ask (L)OOC': '#333333',
  No: '#000000',
  Yes: '#007302',
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
    assigned_view,
  } = data;

  const [overlay, setOverlay] = useState(null);
  const updateOverlay = (character) => {
    setOverlay(character);
  };

  return (
    <Window width={1000} height={800} resizeable>
      <Window.Content scrollable>
        {(overlay && (
          <ViewCharacter
            overlay={overlay}
            updateOverlay={updateOverlay}
            assigned_view={assigned_view}
          />
        )) || (
          <>
            <Section title="Controls">
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
                <LabeledList.Item label="Noncon">
                  <Button fluid>{personalNonconTag}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="Hypnosis">
                  <Button fluid>{personalHypnoTag}</Button>
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <CharacterDirectoryList
              overlay={overlay}
              updateOverlay={updateOverlay}
            />
          </>
        )}
      </Window.Content>
    </Window>
  );
};

const ViewCharacter = (props) => {
  const { overlay, updateOverlay, assigned_view } = props;

  return (
    <Stack fill>
      <Stack.Item>
        <Section height="375px" width="262px" title={overlay.name}>
          <CharacterPreview height="330px" width="250px" id={assigned_view} />
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
                    <LabeledList.Item label="Noncon">
                      {overlay.noncon}
                    </LabeledList.Item>
                    <LabeledList.Item label="Hypnosis">
                      {overlay.hypno}
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
  const { overlay, updateOverlay } = props;

  const { directory, canOrbit, assigned_view } = data;

  const [sortId, _setSortId] = useState('name');
  const [sortOrder, _setSortOrder] = useState('name');

  return (
    <Section
      title="Directory"
      buttons={
        <Button icon="sync" onClick={() => act('refresh')}>
          Refresh
        </Button>
      }
    >
      <Table>
        <Table.Row bold>
          <SortButton id="name">Name</SortButton>
          <SortButton id="species">Species</SortButton>
          <SortButton id="attraction">Attraction</SortButton>
          <SortButton id="gender">Gender</SortButton>
          <SortButton id="erp">ERP</SortButton>
          <SortButton id="vore">Vore</SortButton>
          <SortButton id="noncon">Noncon</SortButton>
          <SortButton id="hypno">Hypnosis</SortButton>
          <Table.Cell collapsing textAlign="right">
            Advert
          </Table.Cell>
        </Table.Row>
        {directory
          .sort((a, b) => {
            const i = sortOrder ? 1 : -1;
            return a[sortId].localeCompare(b[sortId]) * i;
          })
          .map((character, i) => (
            <Table.Row key={i} backgroundColor={erpTagColor[character.erp]}>
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
              <Table.Cell>{character.noncon}</Table.Cell>
              <Table.Cell>{character.hypno}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  onClick={() => {
                    updateOverlay(character);
                    act('view_character', {
                      assigned_view: assigned_view,
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

const SortButton = (props) => {
  const { act, data } = useBackend();

  const { id, children } = props;

  // Hey, same keys mean same data~
  const [sortId, setSortId] = useState('name');
  const [sortOrder, setSortOrder] = useState('name');

  return (
    <Table.Cell collapsing>
      <Button
        width="100%"
        color={sortId !== id && 'transparent'}
        onClick={() => {
          if (sortId === id) {
            setSortOrder(!sortOrder);
          } else {
            setSortId(id);
            setSortOrder(true);
          }
        }}
      >
        {children}
        {sortId === id && (
          <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml={0.25} />
        )}
      </Button>
    </Table.Cell>
  );
};
