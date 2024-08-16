#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
    // vanilla behavior
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    vertexDistance = fog_distance(Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    // shadow behavior
    // by PuckiSilver (https://github.com/PuckiSilver/NoShadow)
    if (Color.r <=0.25 && 
        Color.g <=0.25 &&
        Color.b <=0.25 && (
        Position.z == 0 ||    // Menu
        Position.z == 1 ||    // Jade
        Position.z == 50 ||   // Chat - Opened
        Position.z == 200 ||  // Advancement Screen
        Position.z == 300 ||  // Item Count - Inventory
        Position.z == 398 ||  // Xaero's Minimap
        Position.z == 400 ||  // Item Tooltip
        Position.z == 432 ||  // Item Count - Dragging
        Position.z == 600 ||  // Item Count - Hotbar
        Position.z == 1000 || // Bossbar
        Position.z == 2200 || // Actionbar
        Position.z == 2400 || // Subtitle | Title
        Position.z == 2650 || // Chat - Closed
        Position.z == 2800 || // Scoreboard List
        Position.z == 3250 || // Chat
        Position.z == 3400    // Player List (Tab)
        )) {
        gl_Position = vec4(2,2,2,1); // Move shadow off screen
    }
}
