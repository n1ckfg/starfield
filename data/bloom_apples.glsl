// http://wp.applesandoranges.eu/?p=14

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float intensity;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
    float threshold = 0.0005;
    vec4 col = vec4(0);
    vec4 sum = vec4(0);
    vec2 texcoord = vertTexCoord.st;//vec2(gl_TexCoord[0]);

    for (int i = -4; i < 4; i++) {
        for (int j = -3; j < 3; j++) {
            sum += texture2D(texture, texcoord + vec2(j, i) * 0.004) * 0.25;
        }
    }
       
    if (texture2D(texture, texcoord).r < 0.3) {
       col = sum * sum * 0.012 + texture2D(texture, texcoord);
    } else {
        if (texture2D(texture, texcoord).r < 0.5) {
            col = sum * sum * 0.009 + texture2D(texture, texcoord);
        } else {
            col = sum * sum * intensity + texture2D(texture, texcoord);//0.0075 + texture2D(texture, texcoord);
        }
    }

    gl_FragColor = col;
}