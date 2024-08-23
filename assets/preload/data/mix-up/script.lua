mod = 0;
subMod = 0;
modBeat = 0;
modStep = 0;
started = false;
function create()
    modInit(0);
end

local l = sys.skin.sep;
cnt = {l*1.5, l / 2, -l / 2, -l*1.5};

centerY = 270;
function modInit(Mod)
    mod = Mod;
    subMod = 0;
    modBeat = 0;
    modStep = 0;
    tweenStart({obj_game, "field.0"}, {x = 0, y = 0, z = 0}, 0.1, "inout_quad");
    tweenStart({obj_game, "field.1"}, {x = 0, y = 0, z = 0}, 0.1, "inout_quad");
    for i = 0, 7, 1 do
        prop_set(obj_game, "strums."..i..".lines.0.p", {});
        tweenStart({obj_game, "strums."..i..".lines.0"}, {a = 270, ax = 0, ay = 0, w = 1}, 0.1, "inout_quad");
        tweenStart({obj_game, "strums."..i..".lines.1"}, {a = 270, ax = 0, ay = 0, w = 1}, 0.1, "inout_quad");
        tweenStart({obj_game, "strums."..i..".pos"}, {x = 0, y = 0, z = 0}, 0.1, "inout_quad");
        tweenStart({obj_game, "strums."..i..".ang3D"}, {x = 0, y = 0, z = 0}, 0.1, "inout_quad");
        tweenStart({obj_game, "strums."..i..".dir"}, {x = 0, y = 0, z = 0}, 0.1, "inout_quad");
    end
    if (mod == 0) then
        curSide = 1;
        for i = 0, 7, 1 do
            prop_set(obj_game, "strums."..i..".lines.0.p", {{x = 0, y = 360, z = 0}});
        end
    elseif (mod == 1) then
        for i = 0, 7, 1 do
            prop_set(obj_game, "strums."..i..".lines.0.p", {{x = 0, y = 360, z = 0}});
        end
    elseif (mod == 2) then

        for i = 0, 7, 1 do
            prop_set(obj_game, "strums."..i..".lines.0.p", {{x = 0, y = 720 / 4, z = 0}, {x = 0, y = 720 / 4 * 3, z = 0}});
        end

        local l = sys.skin.sep;
        local woo = l * 0.8;
        for i = 0, 1, 1 do
            --idk
            local num0 = i*4;
            local num1 = i*4 + 1;
            local num2 = i*4 + 2;
            local num3 = i*4 + 3;

            local vdir = 1;

            if (sys.opt.downscroll) then
                vdir = -1;
            end
            tweenStart({obj_game, "strums."..num0..".pos"}, {x = l * 1.5 - woo}, 0.2, "inout_quad");
            tweenStart({obj_game, "strums."..num3..".pos"}, {x = -l * 1.5 + woo}, 0.2, "inout_quad");
            tweenStart({obj_game, "strums."..num1..".pos"}, {x = l / 2, y = woo * vdir}, 0.2, "inout_quad");
            tweenStart({obj_game, "strums."..num2..".pos"}, {x = -l / 2, y = -woo * vdir}, 0.2, "inout_quad");
        end
        tweenStart({obj_game, "field.1"}, {x = 380, y = centerY}, 0.3, "inout_quad");
        tweenStart({obj_game, "field.1"}, {z = -100}, 0.5, "inout_quad");
        tweenStart({obj_game, "field.0"}, {y = 380}, 1, "inout_quad");

        local an = {-90, 0, 180, 90};
        if (sys.opt.downscroll) then
            an[2] = 180;
            an[3] = 0;
        end
        for i = 0, 7, 1 do
            tweenStart({obj_game, "strums."..i..".dir"}, {z = an[i % 4 + 1]}, 0.2, "inout_quad");
        end
    elseif (mod == 3) then
        tweenStart({obj_game, "field.1"}, {x = 380, y = centerY}, 0.8, "out_quad");
        tweenStart({obj_game, "field.0"}, {x = -380, y = centerY}, 0.8, "out_quad");
        for i = 0, 7, 1 do
            tweenStart({obj_game, "strums."..i..".lines.0"}, {ay = -60, w = 0.9}, 0.11, "inout_quad");
            prop_set(obj_game, "strums."..i..".lines.0.p", {{x = 0, y = 200, z = 100}});
            tweenStart({obj_game, "strums."..i..".lines.1"}, {ay = -90}, 0.11, "inout_quad");
            tweenStart({obj_game, "strums."..i..".pos"}, {x = cnt[i%4 + 1]}, 0.11, "inout_quad");
        end
    elseif (mod == 4) then
        for i = 0, 7, 1 do
            local w = 80;
            if (i % 4 < 2) then w = w*-1; end
            tweenStart({obj_game, "strums."..i..".lines.0"}, {ay = -30}, 0.11, "inout_quad");
            prop_set(obj_game, "strums."..i..".lines.0.p", {{x = 0, y = 360, z = 40}});
            tweenStart({obj_game, "strums."..i..".pos"}, {x = cnt[i%4 + 1] + w}, 0.11, "inout_quad");
        end
    elseif (mod == 5) then
        for i = 0, 7, 1 do
            tweenStart({obj_game, "strums."..i..".dir"}, {x = 50}, 1, "inout_quad");
            tweenStart({obj_game, "strums."..i..".ang3D"}, {x = -50}, 1, "inout_quad");
        end
    end
end
rot = 0;
rotspd = 1;
circAng = degtorad(180);

function update(elapsed)
    if (started) then
        if (mod == 0) then
            rot = rot + elapsed * 5;
            for i = 0, 7, 1 do
                prop_set(obj_game, "strums."..i..".pos.z", math.cos(rot + i) * 40);
            end

            if (subMod == 1) then
                for i = 0, 7, 1 do
                    prop_set(obj_game, "strums."..i..".dir.z", math.cos(rot + i) * 10);
                    prop_set(obj_game, "strums."..i..".ang3D.z", math.cos(rot + i) * 4);
                end
            end
        elseif (mod == 3) then
            if (subMod == 2) then
                rotspd = rotspd + elapsed;
            elseif (subMod == 3) then
                rotspd = rotspd - elapsed * 1.21;
                if (rotspd < 0) then
                    rotspd = 0;
                else
                    tweenStart({obj_game, "field.1"}, {x = 380 + math.random(-4, 4), y = centerY + math.random(-4, 4)}, 0.01, "out_quad");
                    tweenStart({obj_game, "field.0"}, {x = -380 + math.random(-4, 4), y = centerY + math.random(-4, 4)}, 0.01, "out_quad");
                end
            end
            circAng = circAng + elapsed * rotspd;
            for i = 0, 7, 1 do
                local off = -((i%4) - 2) / 2.5;
                local len = 300;
                local xlen = len;
                if (subMod >= 1) then xlen = 500; end
                local an = circAng + off;
                if (i < 4) then an = an + degtorad(180); end
                prop_set(obj_game, "strums."..i..".pos.x", cnt[i%4 + 1] + math.cos(an) * xlen);
                prop_set(obj_game, "strums."..i..".pos.y", -math.sin(an) * len);

                prop_set(obj_game, "strums."..i..".dir.z", 270 + radtodeg(an - off));
            end
        elseif (mod == 5) then
            --[[
            for i = 0, 7, 1 do
                prop_set(obj_game, "strums."..i..".pos.z", math.cos(rot + i) * 100);
            end]]
        end
    end
end

function onBeatHit(beat)
    --prop_set(obj_game, "strums.1.pos.x", -40);
    --obj_fnf.gf.prop.beatDance = 4;
    --console_add(s.xscale);
    if (beat == 0) then
        started = true;
    end

    if (started) then
        if (beat == 32) then
            subMod = 1;
        elseif (beat == 64) then
            modInit(1);
        elseif (beat == 128) then
            modInit(2);
        elseif (beat == 192) then
            modInit(3);
        elseif (beat == 256) then
            modInit(4);
        elseif (beat == 296) then
            modInit(0);
        elseif (beat == 288) then
            mod = -1;
            for i = 0, 7, 1 do
                tweenStart({obj_game, "strums."..i..".pos"}, {x = 0, y = 0, z = 0}, 3, "inout_quad");
            end
        elseif (beat == 328) then
            modInit(5);
        elseif (beat == 392) then
            modInit(3);
            subMod = 1;
        elseif (beat == 456) then
            subMod = 2;
        elseif (beat == 464) then
            subMod = 3;
        end
        if (mod == 0) then
            for i = 0, 7, 1 do
                local h = 20;
                if (beat % 2 == 0) then h = h * -1; end
                if (i % 2 == 0) then h = h * -1; end
                tweenStart({obj_game, "strums."..i..".pos"}, {y = 40 + h}, 0.2, "out_quad");
                tweenStart({obj_game, "strums."..i..".pos"}, {y = 0}, 0.2, "in_quad", 0.2);

                --prop_set(obj_game, "strums."..i..".lines.0.p.0.x", h);
                h = 100;
                if (beat % 2 == 0) then h = h * -1; end
                tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = h}, 0.2, "out_quad");
                tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = 0}, 0.2, "in_quad", 0.2);
            end

            if (modBeat % 16 == 0) then
                local oSide = (curSide + 1) % 2;
                local w = 200;
                if (curSide == 0) then
                    w = w * -1;
                end
                tweenStart({obj_game, "field."..curSide}, {x = w, z = 0}, 1, "out_quad");
                tweenStart({obj_game, "field."..oSide}, {x = 0, z = -100}, 1, "out_quad");
                curSide = oSide;
            end
        elseif (mod == 1) then
            local a = 30;
            if (beat % 2 == 1) then a = a * -1; end
            if (beat % 4 == 3) then
                for i = 0, 1, 1 do
                    tweenStart({obj_game, "field."..i}, {z = 100}, 0.3, "out_quad");
                    tweenStart({obj_game, "field."..i}, {z = 0}, 0.3, "in_quad", 0.3);
                end
            end
            for i = 0, 7, 1 do --angle & horizontal bounce
                if (beat % 4 == 3) then
                    prop_set(obj_game, "strums."..i..".ang3D.z", 360);
                end
                tweenStart({obj_game, "strums."..i..".ang3D"}, {z = a / 7}, 0.18, "inout_quad");
                tweenStart({obj_game, "strums."..i..".ang3D"}, {z = 0}, 0.18, "inout_quad", 0.18);

                if (i % 2 == 1) then a = a * -1; end

                local sx = (i % 4) - 2 * 50;
                tweenStart({obj_game, "strums."..i..".pos"}, {x = sx + a * 1.2}, 0.2, "out_quad");
                tweenStart({obj_game, "strums."..i..".pos"}, {x = sx}, 0.2, "in_quad", 0.2);

                if (beat % 4 == i % 4) then
                    tweenStart({obj_game, "strums."..i..".pos"}, {z = -300}, 0.2, "out_quad");
                    tweenStart({obj_game, "strums."..i..".pos"}, {z = 0}, 0.2, "in_quad", 0.2);
                end
            end

            local up = 400;
            local shift = 50;
            if (modBeat == 0) then --show opponent, hide player
                tweenStart({obj_game, "field.1"}, {x = 300, y = shift}, 0.9, "out_quad");
                tweenStart({obj_game, "field.0"}, {y = -300}, 0.5, "in_quad");
            elseif (modBeat == 4) then --shift half receptors upwards (start moving field)
                for i = 4, 7, 2 do
                    tweenStart({obj_game, "strums."..i..".pos"}, {y = up}, 2, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".dir"}, {x = -180}, 2, "inout_quad");
                end
                tweenStart({obj_game, "field.1"}, {x = 500}, 8, "linear");
            elseif (modBeat == 12) then --the other half
                for i = 5, 7, 2 do
                    tweenStart({obj_game, "strums."..i..".pos"}, {y = up}, 2, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".dir"}, {x = -180}, 2, "inout_quad");
                end
            elseif (modBeat == 18) then
                for i = 4, 7, 1 do
                    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = 20}, 1, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".lines.0"}, {w = 0.8, a = 270 - 30}, 1, "inout_quad");
                end
            elseif (modBeat == 26 or modBeat == 28) then
                for i = 4, 7, 1 do
                    tweenStart({obj_game, "strums."..i..".ang3D"}, {x = -45}, 0.2, "out_quad");
                    tweenStart({obj_game, "strums."..i..".ang3D"}, {x = 0}, 0.2, "in_quad", 0.2);
                end
            elseif (modBeat == 30) then --show player hide opponent
                tweenStart({obj_game, "field.1"}, {x = 0, y = -300}, 0.9, "in_quad");
                tweenStart({obj_game, "field.0"}, {x = -200, y = shift}, 0.5, "out_quad");
                for i = 4, 7, 1 do
                    tweenStart({obj_game, "strums."..i..".pos"}, {y = 0}, 1, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".dir"}, {x = 0}, 1, "inout_quad");
                end
            elseif (modBeat == 36) then --movii (starts)
                for i = 0, 3, 2 do
                    tweenStart({obj_game, "strums."..i..".pos"}, {y = up}, 2, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".dir"}, {x = -180}, 2, "inout_quad");
                end
                tweenStart({obj_game, "field.0"}, {x = -400}, 8, "linear");
            elseif (modBeat == 44) then --the other half
                for i = 1, 3, 2 do
                    tweenStart({obj_game, "strums."..i..".pos"}, {y = up}, 2, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".dir"}, {x = -180}, 2, "inout_quad");
                end
            elseif (modBeat == 50) then
                for i = 0, 3, 1 do
                    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = -20}, 1, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".lines.0"}, {w = 0.8, a = 270 + 30}, 1, "inout_quad");
                end
            elseif (modBeat == 58 or modBeat == 60) then
                for i = 0, 3, 1 do
                    tweenStart({obj_game, "strums."..i..".ang3D"}, {x = -45}, 0.2, "out_quad");
                    tweenStart({obj_game, "strums."..i..".ang3D"}, {x = 0}, 0.2, "in_quad", 0.2);
                end
            end
        elseif (mod == 2) then
            if (modBeat % 4 == 0) then
                for i = 0, 7, 1 do
                    prop_set(obj_game, "strums."..i..".lines.0.p.0.z", 0);
                    prop_set(obj_game, "strums."..i..".lines.0.p.1.z", 0);
                    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = 300}, 0.05, "out_quad");
                    tweenStart({obj_game, "strums."..i..".lines.0.p.1"}, {x = -300}, 0.05, "out_quad");
                    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = 0}, 0.3, "in_quad", 0.05);
                    tweenStart({obj_game, "strums."..i..".lines.0.p.1"}, {x = 0}, 0.3, "in_quad", 0.05);
                end
            end
            if (modBeat % 4 == 3) then
                for i = 0, 7, 1 do
                    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = -300}, 0.3, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".lines.0.p.1"}, {x = 300}, 0.3, "inout_quad");
                end
                --[[
                for i = 0, 7, 1 do
                    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {z = 1000}, 0.3, "in_quad");
                    tweenStart({obj_game, "strums."..i..".lines.0.p.1"}, {z = -1000}, 0.3, "in_quad");
                end]]
            end

            local a = 8;
            if (modBeat % 2 == 1) then a = a*-1; end
            for i = 0, 7, 1 do
                tweenStart({obj_game, "strums."..i..".ang3D"}, {z = a}, 0.2, "out_quad");
                tweenStart({obj_game, "strums."..i..".ang3D"}, {z = 0}, 0.2, "in_quad", 0.2);
                local ind = {3, 2, 0, 1}
                if (beat % 4 == ind[i % 4 + 1]) then
                    tweenStart({obj_game, "strums."..i..".ang3D"}, {y = a * 4}, 0.2, "out_quad");
                    tweenStart({obj_game, "strums."..i..".ang3D"}, {y = 0}, 0.2, "in_quad", 0.2);
                end
            end

            if (modBeat == 1) then
                --tweenStart({obj_game, "field.1"}, {z = -200}, 7, "linear");
            elseif (modBeat == 14) then
                tweenStart({obj_game, "field.0"}, {x = -380, y = centerY}, 0.3, "inout_quad");
                tweenStart({obj_game, "field.0"}, {z = -100}, 0.5, "inout_quad");
                tweenStart({obj_game, "field.1"}, {x = 0, z = -400}, 0.2, "inout_quad");
                tweenStart({obj_game, "field.1"}, {y = -400, z = 0}, 0.7, "in_elastic");
            elseif (modBeat == 16) then
                --tweenStart({obj_game, "field.0"}, {z = -200}, 7, "linear");
                for i = 4, 7, 1 do
                    prop_set(obj_game, "strums."..i..".pos.x", 0);
                    prop_set(obj_game, "strums."..i..".pos.y", 0);
                    prop_set(obj_game, "strums."..i..".dir.z", -180);
                end
            elseif (modBeat == 32) then
                tweenStart({obj_game, "field.1"}, {y = 0}, 0.4, "out_quad");
                tweenStart({obj_game, "field.0"}, {x = 0}, 0.6, "inout_quad");
                for i = 4, 7, 1 do
                    tweenStart({obj_game, "strums."..i..".dir"}, {z = 0}, 0.4, "out_quad");
                end
            elseif (modBeat == 46) then
                tweenStart({obj_game, "field.1"}, {y = -400, z = 0}, 0.7, "in_elastic");
                tweenStart({obj_game, "field.0"}, {x = -380}, 0.6, "inout_quad");
            elseif (modBeat == 48) then
                local l = sys.skin.sep;

                tweenStart({obj_game, "strums.0.pos"}, {x = l * 1.5}, 6, "inout_quad");
                tweenStart({obj_game, "strums.3.pos"}, {x = -l * 1.5}, 6, "inout_quad");
                tweenStart({obj_game, "strums.1.pos"}, {x = l / 2, y = 0}, 6, "inout_quad");
                tweenStart({obj_game, "strums.2.pos"}, {x = -l / 2, y = 0}, 6, "inout_quad");

                for i = 0, 3, 1 do
                    tweenStart({obj_game, "strums."..i..".lines.0"}, {a = 270 + 100}, 6, "inout_quad");
                    tweenStart({obj_game, "strums."..i..".lines.1"}, {a = 270 + 100}, 6, "inout_quad");
                end
            end
        elseif (mod == 3) then
            if (subMod < 3) then
                for i = 0, 7, 1 do
                    local h = 20;
                    if (beat % 2 == 0) then h = h * -1; end
                    if (i % 2 == 0) then h = h * -1; end
                    tweenStart({obj_game, "strums."..i..".pos"}, {z = 40 + h}, 0.2, "out_quad");
                    tweenStart({obj_game, "strums."..i..".pos"}, {z = 0}, 0.2, "in_quad", 0.2);
                end
            end

            if (modBeat == 12 or modBeat == 14) then
                tweenStart({obj_game, "field.1"}, {z = -100}, 0.2, "out_quad");
                tweenStart({obj_game, "field.1"}, {z = 0}, 0.2, "in_quad", 0.2);

                tweenStart({obj_game, "field.0"}, {z = 100}, 0.2, "out_quad");
                tweenStart({obj_game, "field.0"}, {z = 0}, 0.2, "in_quad", 0.2);
            elseif (modBeat == 44 or modBeat == 46) then
                tweenStart({obj_game, "field.0"}, {z = -100}, 0.2, "out_quad");
                tweenStart({obj_game, "field.0"}, {z = 0}, 0.2, "in_quad", 0.2);

                tweenStart({obj_game, "field.1"}, {z = 100}, 0.2, "out_quad");
                tweenStart({obj_game, "field.1"}, {z = 0}, 0.2, "in_quad", 0.2);
            end
        elseif (mod == 4) then
            for i = 0, 7, 1 do
                local h = 20;
                if (beat % 2 == 0) then h = h * -1; end
                if (i % 4 >= 2) then h = h * -1; end
                tweenStart({obj_game, "strums."..i..".pos"}, {y = h, z = -h}, 0.1, "out_quad");
                tweenStart({obj_game, "strums."..i..".pos"}, {y = 0, z = 0}, 0.3, "in_quad", 0.1);
            end
        elseif (mod == 5) then
            local dumb = (curSide + 1) % 2
            if (modBeat % 4 == 0) then
                tweenStart({obj_game, "field."..dumb}, {y = 0}, 0.4, "out_elastic");
            end
            if (modBeat % 4 == 3) then
                tweenStart({obj_game, "field."..dumb}, {y = 300}, 0.3, "inout_quad");
            end
            if (modBeat % 32 == 0) then
                local oSide = (curSide + 1) % 2;
                local w = 200;
                if (curSide == 0) then
                    w = w * -1;
                end
                tweenStart({obj_game, "field."..curSide}, {x = w, z = 0}, 1, "out_quad");
                tweenStart({obj_game, "field."..oSide}, {x = 0, z = -100}, 1, "out_quad");
                curSide = oSide;
            end
        end

        modBeat = modBeat + 1;
    end
end
function onStepHit(step)
    if (started) then
        if (mod == 0) then
            if (subMod == 1) then
                for i = 0, 7, 1 do
                    if (step % 8 == 6) then
                        h = -300;
                        if (step % 16 == 6) then h = h * -1; end
                        tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {z = h}, 0.1, "out_back");
                        tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {z = 0}, 0.3, "in_quad", 0.1);
                    end
                end
            end
        elseif (mod == 4) then
            for i = 0, 7, 1 do
                if (step % 8 == 6) then
                    h = -200;
                    --if (step % 16 == 6) then h = h * -1; end
                    if (i % 2 == 1) then h = h * -1; end
                    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = h}, 0.1, "out_back");
                    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {x = 0}, 0.3, "in_quad", 0.1);
                end
            end
        elseif (mod == 5) then
            local i = modStep % 4;
            for j = 0, 1, 1 do
                local num = i + j*4;
                local h = -60;
                if (j == 1) then h = h * -1; end
                tweenStart({obj_game, "strums."..num..".pos"}, {x = h}, 0.2, "out_back");
                tweenStart({obj_game, "strums."..num..".pos"}, {x = 0}, 0.3, "in_quad", 0.1);
            end
        end

        modStep = modStep + 1;
    end
end