// THIS IS A NOVA SECTOR UI FILE
import { useBackend } from 'tgui/backend';
import { BlockQuote, Box, Button, Section, Stack } from 'tgui-core/components';

import { PreferencesMenuData } from '../types';

export function KnownLanguage(props: {
  language: {
    name: string;
    description: string;
    icon: string;
    speaking: boolean;
  };
}) {
  const { act } = useBackend<PreferencesMenuData>();
  return (
    <Stack.Item>
      <Section
        title={
          <>
            <Box
              // Manually putting the icon here instead of using the buttons prop cause it looks better
              mr="2px"
              mb="-4px"
              inline
              className={'languages16x16 ' + props.language.icon}
            />
            <Box inline>{props.language.name}</Box>
          </>
        }
      >
        <BlockQuote>{props.language.description}</BlockQuote>
        <Button.Checkbox
          icon="brain"
          selected
          tooltip="Removing your ability to understand the language will also prevent you from speaking it."
          onClick={() =>
            act('forget_understand_language', {
              language_name: props.language.name,
            })
          }
        >
          Can understand
        </Button.Checkbox>
        <Button.Checkbox
          icon={props.language.speaking ? 'comment' : 'comment-slash'}
          selected={props.language.speaking}
          tooltip={
            props.language.speaking
              ? 'Lose the ability to speak the language, but you keep your understanding of it.'
              : 'Gives you the ability to speak the language.'
          }
          onClick={() =>
            act(
              props.language.speaking
                ? 'forget_speak_language'
                : 'speak_language',
              { language_name: props.language.name },
            )
          }
        >
          Can{!props.language.speaking && "'t"} speak
        </Button.Checkbox>
      </Section>
    </Stack.Item>
  );
}

export function UnknownLanguage(props: {
  language: {
    name: string;
    description: string;
    icon: string;
  };
}) {
  const { act } = useBackend<PreferencesMenuData>();
  return (
    <Stack.Item>
      <Section
        title={
          <>
            <Box
              // Manually putting the icon here instead of using the buttons prop cause it looks better
              mr="2px"
              mb="-3px"
              inline
              className={'languages16x16 ' + props.language.icon}
            />
            <Box inline>{props.language.name}</Box>
          </>
        }
      >
        <BlockQuote>{props.language.description}</BlockQuote>
        <Button
          icon="comment"
          tooltip="Gives you the ability to speak and understand the language."
          onClick={() =>
            act('speak_language', { language_name: props.language.name })
          }
        >
          Learn speech
        </Button>
        <Button
          icon="brain"
          tooltip="Gives you the ability to understand the language but not speak it."
          onClick={() =>
            act('understand_language', { language_name: props.language.name })
          }
        >
          Learn understanding only
        </Button>
      </Section>
    </Stack.Item>
  );
}

export const LanguagesPage = (props) => {
  const { data } = useBackend<PreferencesMenuData>();
  return (
    <>
      <Section textAlign="center">
        Here, you can add languages to your character using a point system. The{' '}
        <b>Linguist</b> neutral quirk will give you one extra point.
        <br />
        Languages may be either <b>spoken and understood</b> or{' '}
        <b>just understood.</b>
        <br />
        One language is worth <b>1 point,</b> even if that language is only
        understood and not spoken.
        <br />
        It does not cost points to toggle speech of a language—it only costs
        points to add an entirely new language.
      </Section>
      <Stack>
        <Stack.Item minWidth="33%">
          <Section
            title={
              <Box fontSize="150%">
                {data.unselected_languages.length} available languages
              </Box>
            }
          >
            <Stack vertical>
              {data.unselected_languages.map((val) => (
                <UnknownLanguage key={val.icon} language={val} />
              ))}
            </Stack>
          </Section>
        </Stack.Item>
        <Stack.Item minWidth="33%">
          <Section
            title={
              <Box fontSize="150%">
                {data.selected_languages.length}/{data.total_language_points}{' '}
                known languages
              </Box>
            }
          >
            <Stack vertical>
              {data.selected_languages.map((val) => (
                <KnownLanguage key={val.icon} language={val} />
              ))}
            </Stack>
          </Section>
        </Stack.Item>
      </Stack>
    </>
  );
};
