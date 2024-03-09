classdef Robot_arm < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        simulationSwitch       matlab.ui.control.Switch
        simulationSwitchLabel  matlab.ui.control.Label
        length2Slider          matlab.ui.control.Slider
        length2SliderLabel     matlab.ui.control.Label
        length1Slider          matlab.ui.control.Slider
        length1SliderLabel     matlab.ui.control.Label
        StartButton            matlab.ui.control.Button
        UIAxes                 matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
hold(app.UIAxes,"off")
L1=app.length1Slider.Value;
L2=app.length2Slider.Value;
theta1=linspace(0,90,1001);
theta2=linspace(0,180,1001);
X1=L1*cosd(theta1);
Y1=L1*sind(theta1);
X2=X1+L2*cosd(theta1+theta2);
Y2=Y1+L2*sind(theta1+theta2);
p1=plot(app.UIAxes,[0,X1(1)],[0,Y1(1)],'r');
hold(app.UIAxes,"on")
p2=plot(app.UIAxes,[X1(1),X2(1)],[Y1(1),Y2(1),'b']);
hold on
xlim(app.UIAxes,[-L1*2,L1*2])
ylim(app.UIAxes,[-L1*2,L1*2])
while(app.simulationSwitch.Value == "On")
for c=1:10:length(theta1)
    delete(p1);
    delete(p2);
    p1=plot(app.UIAxes,[0,X1(c)],[0,Y1(c)],'r');
    p2=plot(app.UIAxes,[X1(c),X2(c)],[Y1(c),Y2(c)],'b');
    drawnow;
end
end

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Robot-Arm')
            xlabel(app.UIAxes, 'X-Axis')
            ylabel(app.UIAxes, 'Y-Axis')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [1 21 469 460];

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.BackgroundColor = [0.902 0.902 0.902];
            app.StartButton.FontSize = 18;
            app.StartButton.FontWeight = 'bold';
            app.StartButton.Position = [513 32 111 51];
            app.StartButton.Text = 'Start';

            % Create length1SliderLabel
            app.length1SliderLabel = uilabel(app.UIFigure);
            app.length1SliderLabel.HorizontalAlignment = 'right';
            app.length1SliderLabel.Position = [472 433 53 22];
            app.length1SliderLabel.Text = 'length(1)';

            % Create length1Slider
            app.length1Slider = uislider(app.UIFigure);
            app.length1Slider.Limits = [0 20];
            app.length1Slider.Position = [546 442 80 3];
            app.length1Slider.Value = 8;

            % Create length2SliderLabel
            app.length2SliderLabel = uilabel(app.UIFigure);
            app.length2SliderLabel.HorizontalAlignment = 'right';
            app.length2SliderLabel.Position = [469 371 53 22];
            app.length2SliderLabel.Text = 'length(2)';

            % Create length2Slider
            app.length2Slider = uislider(app.UIFigure);
            app.length2Slider.Limits = [0 20];
            app.length2Slider.Position = [543 380 86 3];
            app.length2Slider.Value = 7;

            % Create simulationSwitchLabel
            app.simulationSwitchLabel = uilabel(app.UIFigure);
            app.simulationSwitchLabel.HorizontalAlignment = 'center';
            app.simulationSwitchLabel.Position = [540 112 59 22];
            app.simulationSwitchLabel.Text = 'simulation';

            % Create simulationSwitch
            app.simulationSwitch = uiswitch(app.UIFigure, 'slider');
            app.simulationSwitch.Position = [546 149 45 20];
            app.simulationSwitch.Value = 'On';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Robot_arm

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end