// THIS IS A NOVA UI FILE
import { Box, Image, Section, Stack } from 'tgui-core/components';
import { resolveAsset } from '../../assets';

type Props = {
  name: string;
  asset?: string;
  color?: string;
  indefinite?: boolean;
};

export const AntagInfoHeader = (props: Props) => {
  const { name, asset, color, indefinite } = props;
  return (
    <Section>
      <Stack className="AntagInfo__header_outer">
        {!!asset && (
          <Stack.Item className="AntagInfo__header_img">
            <Image
              src={resolveAsset(asset)}
              width="64px"
              style={{
                imageRendering: 'pixelated',
              }}
            />
          </Stack.Item>
        )}
        <Stack.Item grow className="AntagInfo__header_text">
          <h1>
            You are {indefinite ? 'a' : 'the'}{' '}
            <Box inline textColor={color || 'red'}>
              {name}
            </Box>
            !
          </h1>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
