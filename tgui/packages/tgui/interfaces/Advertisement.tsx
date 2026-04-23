// Obnoxious advertisement with moving text and flashing colors
import '../styles/interfaces/Advertisement.scss';

import { storage } from 'common/storage';
import { useEffect, useRef, useState } from 'react';
import { Button, Icon, Modal, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { getWindowSize, setWindowPosition } from '../drag';
import { suspendStart } from '../events/handlers/suspense'
import { Window } from '../layouts';
import { logger } from '../logging';

export interface PopupQuestion {
  question: string;
  button1: string;
  button2: string;
  closesWindow: 'button1' | 'button2';
}

export const popupQuestions: PopupQuestion[] = [
  {
    question:
      'Are you *not* ready to not immediately stop cancelling your choice? (5 seconds left)',
    button1: 'Absolutely Not',
    button2: 'Don’t Cancel',
    closesWindow: 'button1',
  },
  {
    question:
      'Will you confirm that you don’t not want to reject quitting before the timer ends?',
    button1: 'Reject Confirmation',
    button2: 'Agree to Not Reject',
    closesWindow: 'button2',
  },
  {
    question:
      'Are you certain you don’t disagree with avoiding closure... *quickly*?',
    button1: 'Close Avoidance',
    button2: 'Don’t Close Avoidance',
    closesWindow: 'button1',
  },
  {
    question:
      'Do you want to not refuse the option to not end now? Time’s almost up!',
    button1: 'End Refusal',
    button2: 'Refuse End',
    closesWindow: 'button1',
  },
  {
    question: 'Will you not cancel your refusal to not accept leaving?',
    button1: 'Accept Refusal',
    button2: 'Cancel Leaving',
    closesWindow: 'button2',
  },
  {
    question:
      'Are you sure you’re not unsure about not confirming you’re not ready right now?',
    button1: 'Not Ready Confirmed',
    button2: 'Ready Unconfirmed',
    closesWindow: 'button2',
  },
  {
    question:
      'Do you deny not wanting to instantly agree to avoid not quitting?',
    button1: 'Agree Avoid Quit',
    button2: 'Don’t Agree Quit',
    closesWindow: 'button1',
  },
  {
    question: 'Are you sure you don’t want to not close at this exact moment?',
    button1: 'Close Later',
    button2: 'Close Now Not',
    closesWindow: 'button2',
  },
  {
    question:
      'Will you reject not cancelling your attempt to not quit before it’s too late?',
    button1: 'Cancel Attempt',
    button2: 'Reject Cancel',
    closesWindow: 'button1',
  },
  {
    question: 'Do you not refuse to not stop the process now?',
    button1: 'Stop Refusal',
    button2: 'Don’t Stop Refusal',
    closesWindow: 'button2',
  },
  {
    question: 'You don’t not want to avoid declining to quit, right?',
    button1: 'Decline Quit',
    button2: 'Avoid Decline Quit',
    closesWindow: 'button2',
  },
  {
    question:
      'If you’re not unsure about not confirming your decision to not exit, click now!',
    button1: 'Confirm Exit Not',
    button2: 'Don’t Confirm Not Exit',
    closesWindow: 'button1',
  },
  {
    question:
      'Will you not cancel your decision to not leave if you don’t act instantly?',
    button1: 'Cancel Not Leave',
    button2: 'Don’t Cancel Not Leave',
    closesWindow: 'button1',
  },
  {
    question:
      'Are you certain you don’t not want to refuse the choice to not quit right now?',
    button1: 'Refuse Quit',
    button2: 'Don’t Refuse Quit',
    closesWindow: 'button2',
  },
  {
    question:
      'Do you not want to not confirm you don’t want to quit before the popup explodes?',
    button1: 'Confirm Not Quit',
    button2: 'Don’t Confirm Not Quit',
    closesWindow: 'button1',
  },
];

export function getRandomPopup(): PopupQuestion {
  const index = Math.floor(Math.random() * popupQuestions.length);
  return popupQuestions[index];
}

const pickRandomElement = (arr: string[]) =>
  arr[Math.floor(Math.random() * arr.length)];

type Data = {
  severity: number;
  customer: string;
};
const titleVariants = [
  'HOT MOTHS IN YOUR AREA',
  'LOSE FIFTY POUNDS IN A SHIFT',
  'FIND OUT THE TRUTH',
  'LIMITED TIME OFFER',
  'WARNING: SYSTEM BREACH',
  'EQUESTRIAN WOMEN GONE WILD',
  'DEFRAGMENT YOUR HARD DRIVE TODAY',
  'EXTEND YOUR SHUTTLE WARRANTY',
  "YOU WON'T BELIEVE",
];

const bodyVariants = [
  'I bought this and now HUNDREDS WANT ME!',
  "Come robust, M'lord.",
  '4 of 5 Medical Doctors recommend this supplement.',
  'Clean your hard-drive instantly with one weird trick!',
  'Get a grey-tide body with Scientist-level effort!',
  'Mares near you are single, ready to mingle, and have insane stamina!',
  'YOUR OPERATING SYSTEM IS INFECTED, CLICK NOW FOR SUPPORT!!!',
  "We're trying to reach you about your shuttle's extended warranty!",
  'Fundamentally evil people are REAL, click here to learn how to be an empath!',
  'Leaked footage of Nanotrasen CEOs at Spachemian Grove!',
  'Find the location of the PWS Khranitel Revolyutsii today!',
];
const purchasePhrases = [
  '!!BUY NOW!!',
  '!!ACT NOW!!',
  '!!INVEST NOW!!',
  '!!GET NOW!!',
  '!!SHOP NOW!!',
];
const pixelRatio = window.devicePixelRatio ?? 1;
const screenSize: [number, number] = [
  window.screen.availWidth * pixelRatio,
  window.screen.availHeight * pixelRatio,
];
const winSize = getWindowSize();
const position = useRef<[number, number]>([0, 0]);
const hasOpened = useRef(false);
export const Advertisement = () => {
  const { act, data, suspended } = useBackend<Data>();
  const { severity } = data;

  const [header] = useState(pickRandomElement(titleVariants));
  const [body] = useState(pickRandomElement(bodyVariants));
  const [purchasePhrase] = useState(pickRandomElement(purchasePhrases));

  const [popup, setPopup] = useState<PopupQuestion | null>(null);

  const [showClosePrompt, setShowClosePrompt] = useState(false);

  useEffect(() => {
    const relocate_window = setTimeout(() => {
      position.current = [
        Math.random() * Math.max(0, screenSize[0] - winSize[0]),
        Math.random() * Math.max(0, screenSize[1] - winSize[1]),
      ];
      logger.log(position.current);
      storage.remove(Byond.windowId);
      setWindowPosition(position.current);
    }, 300);
    const closeButton = document.getElementsByClassName('TitleBar__close');
    if (closeButton.length > 0) {
      closeButton[0].addEventListener('click', tryCloseWindow);
    }
    return () => {
      clearTimeout(relocate_window);
      if (closeButton.length > 0) {
        closeButton[0].removeEventListener('click', tryCloseWindow);
      }
    };
  }, [suspended]);

  const [closePromptTimeout, setClosePromptTimeout] =
    useState<NodeJS.Timeout>();

  const [closePromptConfirmation, setClosePromptConfirmation] = useState(false);

  const actuallyCloseWindow = () => {
    suspendStart();
  };

  const tryCloseWindow = (event: Event) => {
    event.preventDefault();
    event.stopPropagation();
    setClosePromptConfirmation(false);
    setPopup(getRandomPopup());
    setShowClosePrompt(true);
    setClosePromptTimeout(
      setTimeout(() => {
        setShowClosePrompt(false);
      }, 10000),
    );
  };

  const closePrompt = () => {
    setShowClosePrompt(false);
    if (closePromptTimeout) clearTimeout(closePromptTimeout);
  };

  const handleDeceptiveClick = (pressed: 'button1' | 'button2') => {
    if (!popup) return;
    if (popup.closesWindow === pressed) {
      closePrompt();
      actuallyCloseWindow();
    } else {
      closePrompt();
    }
  };
  return (
    <Window title={header} width={600} height={300} theme="retro">
      <Window.Content>
        {showClosePrompt && popup && (
          <Modal>
            <Stack
              textAlign="center"
              fontSize="1.5em"
              vertical
              fill
              textColor="black"
            >
              <Stack.Item>{popup.question}</Stack.Item>

              <Stack.Item
                style={{
                  display: 'flex',
                  gap: '1em',
                  justifyContent: 'space-between',
                }}
              >
                <Button
                  textAlign="center"
                  fontSize="1.2em"
                  onClick={() => handleDeceptiveClick('button1')}
                >
                  {popup.button1}
                </Button>

                <Button
                  align="right"
                  textAlign="center"
                  fontSize="1.2em"
                  onClick={() => handleDeceptiveClick('button2')}
                >
                  {popup.button2}
                </Button>
              </Stack.Item>

              <Stack.Item>
                {severity < 2 && (
                  <Button.Checkbox
                    checked={closePromptConfirmation}
                    disabled={closePromptConfirmation}
                    onClick={() => {
                      setClosePromptConfirmation(!closePromptConfirmation);
                      act('toggle_close_perma');
                    }}
                  >
                    Do not reopen this window.
                  </Button.Checkbox>
                )}
              </Stack.Item>
            </Stack>
          </Modal>
        )}
        <Section className="Advertisement" fill align="center">
          <Stack textAlign="center" fontSize="1.5em" vertical fill>
            <Stack.Item maxWidth="32rem" align="center">
              {header}
            </Stack.Item>
            <Stack.Item maxWidth="24rem" align="center">
              <span className="Advertisement__marquee">{body}</span>
            </Stack.Item>
            <Stack.Item>
              <Button
                width="24rem"
                height="6rem"
                fontSize="2.5rem"
                textAlign="center"
                verticalAlign="center"
                verticalAlignContent="center"
                onClick={() => {
                  act('purchase');
                }}
              >
                <span className="Advertisement__Blink">{purchasePhrase}</span>
              </Button>
            </Stack.Item>
          </Stack>
          <div>
            <Icon
              className="Advertisement_DollarSign top-left"
              name="sack-dollar"
            />
          </div>
          <div>
            <Icon
              className="Advertisement_DollarSign top-right"
              name="sack-dollar"
            />
          </div>
          <div>
            <Icon
              className="Advertisement_DollarSign bottom-left"
              name="sack-dollar"
            />
          </div>
          <div>
            <Icon
              className="Advertisement_DollarSign bottom-right"
              name="sack-dollar"
            />
          </div>
        </Section>
      </Window.Content>
    </Window>
  );
};
