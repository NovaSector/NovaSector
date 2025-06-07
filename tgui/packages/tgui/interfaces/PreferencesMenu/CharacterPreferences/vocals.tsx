import { binaryInsertWith, sortBy } from 'common/collections';
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

import { Name } from '../types';
import { useServerPrefs } from '../useServerPrefs';
import { createLogger } from '../../../../tgui-dev-server/logging';

type VocalsProps = {
  handleClose: () => void;
  handleUpdateName: (nameType: string, value: string) => void;
  vocals: Record<string, string | number | boolean>;
};

export function VocalsInput(props: VocalsProps) {
  const { vocals, handleUpdateName, handleClose } = props;
  const [currentlyEditing, setCurrentlyEditing] = useState<string | null>(null);

  const getLabel = (key: string) => {
    switch (key) {
      case 'voice_type':
        return 'Voice Type';
      case 'blooper_speech':
        return 'Blooper Speech';
      case 'blooper_speech_speed':
        return 'Blooper Speed';
      case 'blooper_speech_pitch':
        return 'Blooper Pitch';
      case 'fallback_to_blooper':
        return 'Fallback to Blooper';
      default:
        return key;
    }
  };

  const isEditable = (val: any) =>
    typeof val === 'string' || typeof val === 'number';

  return (
    <Modal>
      <TrackOutsideClicks onOutsideClick={props.handleClose}>
        <Section
          title="Voice Settings"
          buttons={
            <Button color="red" onClick={props.handleClose}>
              Close
            </Button>
          }
        >
          <LabeledList>
            {Object.entries(vocals).map(([key, value]) => {
              const label = getLabel(key);
              let content;

              if (currentlyEditing === key && isEditable(value)) {
                content = (
                  <Input
                    value={String(value)}
                    onEnter={(e, val) => {
                      handleUpdateName(key, val);
                      setCurrentlyEditing(null);
                    }}
                    onChange={(e, val) => handleUpdateName(key, val)}
                    onEscape={() => setCurrentlyEditing(null)}
                    autoSelect
                  />
                );
              } else if (typeof value === 'boolean') {
                content = (
                  <Button
                    onClick={() => handleUpdateName(key, String(!value))}
                    width="100%"
                  >
                    {value ? 'Yes' : 'No'}
                  </Button>
                );
              } else {
                content = (
                  <Button
                    onClick={(e) => {
                      setCurrentlyEditing(key);
                      e.stopPropagation();
                    }}
                    width="100%"
                  >
                    <FitText maxFontSize={12} maxWidth={130}>
                      {String(value)}
                    </FitText>
                  </Button>
                );
              }

              return (
                <LabeledList.Item key={key} label={label}>
                  <Stack fill>
                    <Stack.Item grow>{content}</Stack.Item>
                  </Stack>
                </LabeledList.Item>
              );
            })}
          </LabeledList>
        </Section>
      </TrackOutsideClicks>
    </Modal>
  );
}

type VoiceInputProps = {
  openVocalsInput: () => void;
  handleUpdateName: (nameType: string, value: string) => void;
  vocals: Record<string, string | number | boolean>;
};

export function VoiceInput(props: VoiceInputProps) {
  return (
    <Button
      onClick={(event) => {
        props.openVocalsInput();
        event.cancelBubble = true;
        event.stopPropagation();
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
            name="fa-comment"
          />
        </Stack.Item>

        <Stack.Item grow position="relative" mt={0.6}>
          <FitText maxFontSize={16} maxWidth={130}>
            Voice Settings
          </FitText>
        </Stack.Item>
      </Stack>
    </Button>
  );
}
