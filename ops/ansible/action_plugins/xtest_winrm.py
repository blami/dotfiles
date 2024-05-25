from __future__ import absolute_import, division, print_function

__metaclass__ = type

try:
    import winrm

    HAS_PYWINRM = True
except ImportError as e:
    HAS_PYWINRM = False

from base64 import b64encode

from ansible.plugins.action import ActionBase


class ActionModule(ActionBase):
    """Test if WinRM connection can be made with given parameters"""

    def run(self, tmp=None, task_vars=None):
        result = super(ActionModule, self).run(tmp, task_vars)
        del tmp  # tmp no longer has any effect

        args = self._task.args

        hostname = args.get("hostname", "localhost")
        port = args.get("port", 5986)
        scheme = args.get("scheme", "http" if port == 5985 else "https")
        path = args.get("winrm_path", "/wsman")
        script = args.get("script", "Get-Host")

        result["can_winrm"] = True
        result["has_pywinrm"] = HAS_PYWINRM
        try:
            # Attempt to connect to WinRM and run PS command.
            proto = winrm.protocol.Protocol(
                endpoint=f"{scheme}://{hostname}:{port}{path}",
                transport=args.get("winrm_transport", "ntlm"),
                username=args.get("username"),
                password=args.get("password"),
                cert_pem=args.get("winrm_cert_pem"),
                cert_key_pem=args.get("winrm_cert_key_pem"),
                server_cert_validation=args.get("winrm_server_cert_validation"),
                # TODO: Kerberos is not supported here...
                read_timeout_sec = 5,
                operation_timeout_sec = 4,
                proxy=args.get("proxy", None),
            )
            shell = proto.open_shell()
            encoded_script = b64encode(script.encode("utf_16_le")).decode("ascii")
            cmd = proto.run_command(
                shell, f"powershell.exe -EncodedCommand {encoded_script}"
            )
            stdout, stderr, rc = proto.get_command_output(shell, cmd)
            proto.close_shell(shell)

            result["stdout"] = stdout
            result["stdout_lines"] = stdout.splitlines()
            result["stderr"] = stderr
            result["stderr_lines"] = stderr.splitlines()
            result["rc"] = rc
        except Exception as err:
            result["msg"] = str(err)
            result["can_winrm"] = False

        result["changed"] = False

        return result
