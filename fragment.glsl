varying vec3 normal;
varying vec4 world_position;

void main()
{   
    vec4 ambient, diffuse, specular;

    // Ambient
    ambient = gl_LightModel.ambient * gl_FrontMaterial.ambient;

    // Loop through every light
    for(unsigned i = 0; i < gl_MaxLights; i++){
        // Current Light
        vec3 l = normalize(gl_LightSource[i].position.xyz - world_position.xyz);

        // Diffuse
        double diffuse_intensity = max(dot(l, normal), 0.0);
        diffuse += gl_LightSource[i].diffuse * gl_FrontMaterial.diffuse * diffuse_intensity;

        // Specular
        vec3 r = normalize(2 * dot(l, normal) * normal - l);
        double specular_intensity = pow(max(dot(vec4(r, 0), -world_position.xyz), 0.0), gl_FrontMaterial.shininess);
        specular += gl_LightSource[0].specular * gl_FrontMaterial.specular * specular_intensity;
    }
    
    gl_FragColor = ambient + diffuse + specular;
}
