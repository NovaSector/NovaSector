import { binaryInsertWith } from 'common/collections';
import { sortBy } from 'es-toolkit';
import { useState } from 'react';
import {
  Box,
  Button,
  FitText,
  Icon,
  Input,
  LabeledList,
  Modal,
  Section,
  Stack,
  TrackOutsideClicks,
} from 'tgui-core/components';

import type { Name } from '../types';
import { useServerPrefs } from '../useServerPrefs';

type NameWithKey = {
  key: string;
  name: Name;
};

function binaryInsertName(
  collection: NameWithKey[],
  value: NameWithKey,
): NameWithKey[] {
  return binaryInsertWith(collection, value, ({ key }) => key);
}

function sortNameWithKeyEntries(array: [string, NameWithKey[]][]) {
  return sortBy(array, [([key]) => key]);
}

type MultiNameProps = {
  handleClose: () => void;
  handleRandomizeName: (nameType: string) => void;
  handleUpdateName: (nameType: string, value: string) => void;
  names: Record<string, string>;
};

export function MultiNameInput(props: MultiNameProps) {
  const { handleUpdateName, handleRandomizeName } = props;

  const data = useServerPrefs();
  if (!data) return;

  const namesIntoGroups: Record<string, NameWithKey[]> = {};

  for (const [key, name] of Object.entries(data.names.types)) {
    namesIntoGroups[name.group] = binaryInsertName(
      namesIntoGroups[name.group] || [],
      {
        key,
        name,
      },
    );
  }

  return (
    <Modal>
      <TrackOutsideClicks onOutsideClick={props.handleClose}>
        <Section
          buttons={
            <Button color="red" onClick={props.handleClose}>
              Close
            </Button>
          }
          title="Alternate names"
        >
          <LabeledList>
            {sortNameWithKeyEntries(Object.entries(namesIntoGroups)).map(
              ([_, names], index, collection) => (
                <>
                  {names.map(({ key, name }) => {
                    // NOVA EDIT ADDITION START - DRONE PREFIXES
                    // Get prefixes from backend if available
                    const allPrefixes = name.prefixes || [];

                    // Current value stored in props.names[key], default if empty
                    const currentValue =
                      props.names[key] || `${allPrefixes[0] || ''}-001`;
                    const [prefix, suffix] = currentValue.split('-');
                    // NOVA EDIT ADDITION END
                    return (
                      <LabeledList.Item key={key} label={name.explanation}>
                        <Stack fill>
                          {/* NOVA EDIT REMOVAL START - DRONE NAMING (the removed part is integrated in the added block below)
                          <Stack.Item grow>
                            <Button.Input
                              fluid
                              onCommit={(value) => handleUpdateName(key, value)}
                              value={props.names[key]}
                            />
                          </Stack.Item>
                          NOVA EDIT REMOVAL END*/}
                          {/* NOVA EDIT ADDITION START - DRONE NAMING */}
                          {key === 'drone_name' ? (
                            <>
                              {/* Prefix dropdown */}
                              <Stack.Item>
                                <select
                                  style={{
                                    background: 'rgba(0, 0, 0, 0.3)',
                                    color: 'white',
                                    padding: '2px 4px',
                                    border:
                                      '1px solid rgba(255, 255, 255, 0.2)',
                                    borderRadius: '4px',
                                  }}
                                  value={prefix || ''}
                                  onChange={(e) => {
                                    props.handleUpdateName(
                                      key,
                                      `${e.target.value}-${suffix || ''}`,
                                    );
                                  }}
                                >
                                  {allPrefixes.map((pref) => (
                                    <option key={pref} value={pref}>
                                      {pref}
                                    </option>
                                  ))}
                                </select>
                              </Stack.Item>

                              {/* Suffix input with commit behavior */}
                              <Stack.Item grow>
                                <Button.Input
                                  fluid
                                  maxLength={3}
                                  onCommit={(value) => {
                                    if (/^\d{0,3}$/.test(value)) {
                                      const padded = value.padStart(3, '0');
                                      props.handleUpdateName(
                                        key,
                                        `${prefix}-${padded}`,
                                      );
                                    }
                                  }}
                                  value={suffix || ''}
                                />
                              </Stack.Item>
                            </>
                          ) : (
                            /* Default case for other names */
                            <Stack.Item grow>
                              <Button.Input
                                fluid
                                onCommit={(value) =>
                                  handleUpdateName(key, value)
                                }
                                value={props.names[key]}
                              />
                            </Stack.Item>
                          )}

                          {/* Randomize button — works for drone_name too */}
                          {/* NOVA EDIT ADDITION END*/}
                          {!!name.can_randomize && (
                            <Stack.Item>
                              <Button
                                icon="dice"
                                tooltip="Randomize"
                                tooltipPosition="right"
                                onClick={() => handleRandomizeName(key)}
                              />
                            </Stack.Item>
                          )}
                        </Stack>
                      </LabeledList.Item>
                    );
                  })}

                  {index !== collection.length - 1 && <LabeledList.Divider />}
                </>
              ),
            )}
          </LabeledList>
        </Section>
      </TrackOutsideClicks>
    </Modal>
  );
}

type NameInputProps = {
  handleUpdateName: (name: string) => void;
  name: string;
  openMultiNameInput: () => void;
};

export function NameInput(props: NameInputProps) {
  const [lastNameBeforeEdit, setLastNameBeforeEdit] = useState<string | null>(
    null,
  );
  const editing = lastNameBeforeEdit === props.name;

  function updateName(value) {
    setLastNameBeforeEdit(null);
    props.handleUpdateName(value);
  }

  const data = useServerPrefs();

  return (
    <Button
      captureKeys={!editing}
      onClick={() => {
        setLastNameBeforeEdit(props.name);
      }}
      textAlign="center"
      width="100%"
      height="28px"
    >
      <Stack align="center" fill>
        <Stack.Item>
          <Icon
            style={{
              color: 'rgba(255, 255, 255, 0.5)',
              fontSize: '17px',
            }}
            name="edit"
          />
        </Stack.Item>

        <Stack.Item grow position="relative">
          {editing ? (
            <Input
              autoSelect
              onBlur={updateName}
              onEscape={() => {
                setLastNameBeforeEdit(null);
              }}
              value={props.name}
            />
          ) : (
            <FitText maxFontSize={16} maxWidth={130}>
              {props.name}
            </FitText>
          )}

          <Box
            style={{
              borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
              right: '50%',
              transform: 'translateX(50%)',
              position: 'absolute',
              width: '90%',
              bottom: '-1px',
            }}
          />
        </Stack.Item>

        {/* We only know other names when the server tells us */}
        {data?.names && (
          <Stack.Item>
            <Button
              as="span"
              tooltip="Alternate Names"
              tooltipPosition="bottom"
              style={{
                background: 'rgba(0, 0, 0, 0.7)',
                position: 'absolute',
                right: '2px',
                top: '50%',
                transform: 'translateY(-50%)',
                width: '2%',
              }}
              onClick={(event) => {
                props.openMultiNameInput();

                // We're a button inside a button.
                // Did you know that's against the W3C standard? :)
                event.cancelBubble = true;
                event.stopPropagation();
              }}
            >
              <Icon
                name="ellipsis-v"
                style={{
                  position: 'relative',
                  left: '-1px',
                  minWidth: '0px',
                }}
              />
            </Button>
          </Stack.Item>
        )}
      </Stack>
    </Button>
  );
}
