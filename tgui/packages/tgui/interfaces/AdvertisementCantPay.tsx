import { Box, Section, Stack } from 'tgui-core/components';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { getScreenSize, recallWindowGeometry } from '../drag';
import { Pane } from '../layouts';

type Data = {
  customer: string;
};

const resizeWindow = () => recallWindowGeometry({ size: getScreenSize() });
export const AdvertisementCantPay = () => {
  const { act, data } = useBackend<Data>();
  resizeWindow();
  return (
    <Pane theme="retro">
      <Box height="100%" textAlign="center" fontSize="32px">
        <Stack vertical fill>
          <Stack.Item>
            <Section title="Advertisement (20 Seconds...)">
              Hello, {data.customer}!<br />
              {"You're"} <span className="Advertisement__Blink">TOO POOR</span>{' '}
              to afford this subscription at the price of 100 Credits, so{' '}
              {"we're"} giving you a{' '}
              <span className="Advertisement__Blink">SPECIAL OFFER</span> to get
              this subscription! It might be slow, but at least {"it's"} free!
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Section fill title="SPACE COLA">
              <span className="rainbow-text">
                Enjoy a refreshing SPACE COLA beverage today, from the nearest
                Space Cola Vendor!
              </span>
              <br />
              <img
                className="Advertisement__Cola"
                width="10%"
                src={resolveAsset('space_cola.png')}
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Box>
    </Pane>
  );
};
